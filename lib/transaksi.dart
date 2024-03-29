import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_spp/dashboard.dart';
import 'package:manajemen_spp/models.dart';
import 'package:manajemen_spp/repository.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final user = FirebaseAuth.instance.currentUser!;

  List<Bayar> listBayar = [];
  RepositoryBayar repositoryBayar = RepositoryBayar();
  List<Siswa> listSiswa = [];
  Repository repositorySiswa = Repository();
  bool isLoading = true;
  bool isSortAscending = true;

  getData() async {
    try {
      listBayar = await repositoryBayar.getData();
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      // Tangani error dengan sesuai, misalnya tampilkan pesan kesalahan
      print('Error: $error');
      setState(() {
        isLoading = false;
        listBayar = []; // Set listBayar ke daftar kosong
      });
    }
  }

  getDataSiswa() async {
    try {
      listSiswa = await repositorySiswa.getDataSiswa();
      setState(() {});
    } catch (error) {
      // Tangani error dengan sesuai, misalnya tampilkan pesan kesalahan
      print('Error: $error');
      setState(() {
        listSiswa = []; // Set listSiswa ke daftar kosong
      });
    }
  }

  void toggleSort() {
    setState(() {
      isSortAscending = !isSortAscending;
      listBayar.sort((a, b) {
        if (isSortAscending) {
          return a.createdAt.compareTo(b.createdAt);
        } else {
          return b.createdAt.compareTo(a.createdAt);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getDataSiswa();
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = user.email!;
    String username;
    String url = 'http://192.168.212.32:5000/images/';

    if (userEmail == '210180187@siswa.ac.id') {
      username = 'Irvan Nasyakban';
    } else if (userEmail == '210180197@siswa.ac.id') {
      username = 'Muhammad Ariansyah';
    } else if (userEmail == '210180184@siswa.ac.id') {
      username = 'Widia Hamsi';
    } else if (userEmail == '210180100@siswa.ac.id') {
      username = 'Deny Andrian';
    } else if (userEmail == '210180101@siswa.ac.id') {
      username = 'Fata Albana';
    } else if (userEmail == '210180102@siswa.ac.id') {
      username = 'Zulfikri';
    } else if (userEmail == '210180103@siswa.ac.id') {
      username = 'Agil';
    } else {
      username = 'Fannisa Nadira';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA5A808),
        title: Text(
          'Riwayat Transaksi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Dashboard();
                },
              ),
            );
          },
        ),
      ),
      body: Container(
        color: Color(0xFFE5E7A9),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFfB9E45E),
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  for (var siswaImage in listSiswa)
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      title: Text(username,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black)),
                      subtitle: Text('SMAN 1 WATES',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.black54)),
                      trailing: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(url + siswaImage.image),
                      ),
                    ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 125, right: 135),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      toggleSort();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFA5A808),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Sortir Tanggal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Icon(
                            isSortAscending
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            if (isLoading)
              Center(
                child:
                    CircularProgressIndicator(), // Menampilkan loading spinner
              )
            else if (listBayar.isNotEmpty)
              for (var bayar in listBayar)
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).popAndPushNamed('/bukti',
                          arguments: [bayar.id.toString(), bayar.image, bayar.status]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFfB9E45E),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          ProfileDetailColumn(
                            title: 'Nama           : ' + bayar.nama,
                          ),
                          ProfileDetailColumn(
                            title: 'Kelas            : ' + bayar.kelas,
                          ),
                          ProfileDetailColumn(
                            title: 'Semester     : ' + bayar.semester,
                          ),
                          ProfileDetailColumn(
                            title: 'Jumlah         : ' + bayar.jumlah,
                          ),

                             ProfileDetailColumn(
                            title: 'Status        : ' + bayar.status,
                          ),
                          ProfileDetailColumn(
                            title: 'Tanggal        : ' +
                                bayar.createdAt.substring(0, 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            else
              Text(
                'Tidak ada data Transaksi.', // Pesan jika listSiswa kosong
                style: TextStyle(
                  color: Colors.black
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromARGB(255, 31, 27, 27),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 354,
        )
      ],
    );
  }
}
