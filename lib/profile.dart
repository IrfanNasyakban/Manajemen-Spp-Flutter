import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_spp/repository.dart';
import 'package:manajemen_spp/models.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final user = FirebaseAuth.instance.currentUser!;

  List<Siswa> listSiswa = [];
  Repository repository = Repository();
  bool isLoading = true;

  getDataSiswa() async {
    try {
      listSiswa = await repository.getDataSiswa();
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      // Tangani error dengan sesuai, misalnya tampilkan pesan kesalahan
      print('Error: $error');
      setState(() {
        isLoading = false;
        listSiswa = []; // Set listSiswa ke daftar kosong
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataSiswa();
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = user.email!;
    String username;
    String url = 'http://192.168.0.100:5000/images/';

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
        title: Text('Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 35),
                for (var siswaImage in listSiswa)
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
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
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(200)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(), // Menampilkan loading spinner
            )
          else if (listSiswa.isNotEmpty)
            Column(
              children: [
                ProfileDetailColumn(
                  title: 'Nama',
                  value: username,
                ),
                const SizedBox(height: 10),
                ProfileDetailColumn(
                  title: 'Email',
                  value: user.email!,
                ),
                const SizedBox(height: 20),
                for (var siswa in listSiswa)
                  Column(
                    children: [
                      ProfileDetailColumn(
                        title: 'NIS',
                        value: siswa.nis,
                      ),
                      const SizedBox(height: 20),
                      ProfileDetailColumn(
                        title: 'Tempat, Tanggal Lahir',
                        value: siswa.ttl,
                      ),
                      const SizedBox(height: 20),
                      ProfileDetailColumn(
                        title: 'Alamat',
                        value: siswa.alamat,
                      ),
                      const SizedBox(height: 20),
                      ProfileDetailColumn(
                        title: 'Orang Tua',
                        value: siswa.ibu,
                      ),
                    ],
                  ),
              ],
            )
          else
            Text(
              'Tidak ada data siswa.', // Pesan jika listSiswa kosong
            ),
        ],
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                width: 320,
                child: Divider(
                  thickness: 1.0,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
