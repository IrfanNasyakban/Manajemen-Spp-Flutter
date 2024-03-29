import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manajemen_spp/repository.dart';
import 'package:manajemen_spp/models.dart';
import 'package:manajemen_spp/transaksi.dart';

class BuktiBayar extends StatefulWidget {
  const BuktiBayar({super.key});

  @override
  State<BuktiBayar> createState() => _BuktiBayarState();
}

class _BuktiBayarState extends State<BuktiBayar> {
  final user = FirebaseAuth.instance.currentUser!;

  List<Siswa> listSiswa = [];
  Repository repository = Repository();
  List<Bayar> listBayar = [];
  RepositoryBayar repositoryBayar = RepositoryBayar();
  final _imageController = TextEditingController();
  final _statusController = TextEditingController();

  Color _getStatusColor(String status) {
    if (status == 'ON PROGRESSING') {
      return Colors.orange;
    } else if (status == 'BELUM LUNAS') {
      return Colors.red;
    } else if (status == 'LUNAS') {
      return Colors.green;
    } else {
      return Colors.black; // warna default jika tidak ada status yang cocok
    }
  }

  getDataSiswa() async {
    try {
      listSiswa = await repository.getDataSiswa();
      setState(() {});
    } catch (error) {
      // Tangani error dengan sesuai, misalnya tampilkan pesan kesalahan
      print('Error: $error');
      setState(() {
        listSiswa = []; // Set listSiswa ke daftar kosong
      });
    }
  }

  getData() async {
    try {
      listBayar = await repositoryBayar.getData();
      setState(() {});
    } catch (error) {
      // Tangani error dengan sesuai, misalnya tampilkan pesan kesalahan
      print('Error: $error');
      setState(() {
        listBayar = []; // Set listBayar ke daftar kosong
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataSiswa();
    getData();
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

    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      _imageController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _statusController.text = args[2];
    }

    return Scaffold(
      backgroundColor: Color(0xFFE5E7A9),
      appBar: AppBar(
        title: Text(
          'Bukti Pembayaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFA5A808),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Transaksi();
                },
              ),
            );
          },
        ),
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFfB9E45E),
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 460,
                  width: 360,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple, //color of border
                      width: 2, //width of border
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'KARTU BUKTI PEMBAYARAN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'SMA NEGERI 1 WATES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Jl. Terbahsari Nomor 1, Terbah, Wates, Kulon Progo, D.I. Yogyakarta 55651',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Telp : (0274) 773067',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Email : smu1_wates@yahoo.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pembayaran SPP anda sedang kami Cek Oleh Pihak Administrasi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Berikut Status Pembayaran :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _statusController.text.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(
                              _statusController.text.toUpperCase()),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 200, // Lebar gambar
                        height: 150,
                        child: Image.network(url + _imageController.text),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
