import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_spp/dashboard.dart';
import 'package:manajemen_spp/editprofile.dart';
import 'package:manajemen_spp/repository.dart';
import 'package:manajemen_spp/models.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
        title: Text('Profile'),
        backgroundColor: Color(0xFFA5A808),
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
                  for (var siswa in listSiswa)
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
                        backgroundImage: NetworkImage(url + siswa.image),
                      ),
                    ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              Center(
                child:
                    CircularProgressIndicator(), // Menampilkan loading spinner
              )
            else if (listSiswa.isNotEmpty)
              for (var siswa in listSiswa)
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Color(0xFFA5A808),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        ProfileDetailColumn(
                          title: 'Nama               : ' + siswa.nama,
                        ),
                        ProfileDetailColumn(
                          title: 'Email                : ' + siswa.email,
                        ),
                        ProfileDetailColumn(
                          title: 'Kelas                : ' + siswa.kelas,
                        ),
                        ProfileDetailColumn(
                          title: 'Semester         : ' + siswa.semester,
                        ),
                        ProfileDetailColumn(
                          title: 'NIS                    : ' + siswa.nis,
                        ),
                        ProfileDetailColumn(
                          title: 'TTL                   : ' + siswa.ttl,
                        ),
                        ProfileDetailColumn(
                          title: 'Alamat             : ' + siswa.alamat,
                        ),
                        ProfileDetailColumn(
                          title: 'Wali Kelas       : ' + siswa.wali_kelas,
                        ),
                        ProfileDetailColumn(
                          title: 'Nama Ayah     : ' + siswa.ayah,
                        ),
                        ProfileDetailColumn(
                          title: 'Pekerjaan        : ' + siswa.pekerjaan_ayah,
                        ),
                        ProfileDetailColumn(
                          title: 'Nama Ibu         : ' + siswa.ibu,
                        ),
                        ProfileDetailColumn(
                          title: 'Pekerjaan        : ' + siswa.pekerjaan_ibu,
                        ),
                        ProfileDetailColumn(
                          title: 'No. HP             : ' + siswa.no_hp,
                        ),
                      ],
                    ),
                  ),
                )
            else
              Text(
                'Tidak ada data Profile.', // Pesan jika listSiswa kosong
              ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditProfile();
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 72, right: 72, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFA5A808),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Dashboard();
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 55, right: 55, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFA5A808),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Kembali',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
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
          width: 354,
        ),
      ],
    );
  }
}
