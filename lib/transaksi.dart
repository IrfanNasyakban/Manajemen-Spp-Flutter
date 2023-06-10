import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_spp/bukti.dart';
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
    String url = 'http://192.168.239.32:5000/images/';

    if (userEmail == 'irfan@gmail.com') {
      username = 'Irvan Nasyakban';
    } else if (userEmail == 'ari@gmail.com') {
      username = 'Muhammad Ariansyah';
    } else if (userEmail == 'widia@gmail.com') {
      username = 'Widia Hamsi';
    } else {
      username = 'Fannisa Nadira';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 40, 26, 63),
        title: Text(
          'Riwayat Transaksi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 34, 31, 38),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 40, 26, 63),
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
                              ?.copyWith(color: Colors.white)),
                      subtitle: Text('SMAN 1 WATES',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white54)),
                      trailing: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(url + siswaImage.image),
                      ),
                    ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (isLoading)
              Center(
                child:
                    CircularProgressIndicator(), // Menampilkan loading spinner
              )
            else if (listBayar.isNotEmpty)
              for (var bayar in listBayar)
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 40, 26, 63),
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
                          title: 'Tanggal        : ' +
                              bayar.createdAt.substring(0, 10),
                        ),
                        ProfileDetailColumnKlik(title: 'Bukti             :'),
                      ],
                    ),
                  ),
                )
            else
              Text(
                'Tidak ada data Transaksi.', // Pesan jika listSiswa kosong
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
            color: Colors.white,
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

class ProfileDetailColumnKlik extends StatelessWidget {
  const ProfileDetailColumnKlik({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  // Aksi yang ingin dilakukan saat teks "Klik Disini" di-tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BuktiBayar();
                      },
                    ),
                  );
                },
                child: Text(
                  'Klik Disini',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
