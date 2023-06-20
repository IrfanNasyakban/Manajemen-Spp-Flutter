import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manajemen_spp/dashboard.dart';
import 'package:manajemen_spp/repository.dart';
import 'package:manajemen_spp/models.dart';
import 'package:http/http.dart' as http;

class FormBayar extends StatefulWidget {
  const FormBayar({super.key});

  @override
  State<FormBayar> createState() => _FormBayarState();
}

class _FormBayarState extends State<FormBayar> {
  File? image;
  final _picker = ImagePicker();
  RepositoryBayar repository = RepositoryBayar();
  final _textNamaController = TextEditingController();
  final _textKelasController = TextEditingController();
  final _textSemesterController = TextEditingController();
  final _textJumlahController = TextEditingController();

  List<Siswa> listSiswa = [];
  Repository repositorySiswa = Repository();

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

  Future<bool> postData(String nama, String kelas, String semester,
      String jumlah, String imagePath) async {
    try {
      // Buat objek FormData untuk mengirim data dan file
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.128.32:5000/bayar'),
      );

      // Tambahkan field data ke FormData
      request.fields['nama'] = nama;
      request.fields['kelas'] = kelas;
      request.fields['semester'] = semester;
      request.fields['jumlah'] = jumlah;

      // Tambahkan file ke FormData
      var file = await http.MultipartFile.fromPath('file', imagePath);
      request.files.add(file);

      // Kirim permintaan ke API
      var response = await request.send();

      if (response.statusCode == 201) {
        // Berhasil mengirim data
        return true;
      } else {
        // Gagal mengirim data
        return false;
      }
    } catch (error) {
      // Tangani error dengan sesuai, misalnya tampilkan pesan kesalahan
      print('Error: $error');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getDataSiswa();
  }

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('no image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    _textJumlahController.text = 500000.toString();
    if (listSiswa.isNotEmpty) {
      _textNamaController.text =
          listSiswa[0].nama; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textKelasController.text =
          listSiswa[0].kelas; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textSemesterController.text = listSiswa[0]
          .semester; // Mengisi nilai nama siswa dari API ke textfield
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran SPP'),
        backgroundColor: Color.fromARGB(255, 53, 17, 110),
      ),
      body: Container(
        color: Color.fromARGB(255, 34, 31, 38),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Silahkan Input Data Pembayaran',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 57, 44, 89),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                            style: TextStyle(color: Colors.white),
                            enabled: false,
                            controller: _textNamaController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nama',
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 57, 44, 89),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                            enabled: false,
                            style: TextStyle(color: Colors.white),
                            controller: _textKelasController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Kelas',
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 57, 44, 89),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                            style: TextStyle(color: Colors.white),
                            controller: _textSemesterController,
                            decoration: InputDecoration(
                              enabled: false,
                              border: InputBorder.none,
                              hintText: 'Semester',
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 57, 44, 89),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                            enabled: false,
                            style: TextStyle(color: Colors.white),
                            controller: _textJumlahController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Jumlah',
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 260),
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        child: image == null
                            ? Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 67, 44, 113),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Pick Image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            : Container(
                                child: Center(
                                  child: Image.file(
                                    File(image!.path).absolute,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // Sign in Button
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: GestureDetector(
                          onTap: () {
                            String nama = _textNamaController.text;
                            String kelas = _textKelasController.text;
                            String semester = _textSemesterController.text;
                            String jumlah = _textJumlahController.text;

                            postData(nama, kelas, semester, jumlah, image!.path)
                                .then((success) {
                              if (success) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Pesan'),
                                      content: Text('Data berhasil dikirim'),
                                      actions: <Widget>[
                                        TextButton(
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
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Pesan'),
                                      content: Text('Gagal mengirim data'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 65, right: 65, top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Kirim',
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
                              color: Colors.deepPurple,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
