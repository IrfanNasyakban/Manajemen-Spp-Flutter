import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manajemen_spp/dashboard.dart';
import 'package:manajemen_spp/repository.dart';

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
  final _textBuktiController = TextEditingController();

  

  Future getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        _textBuktiController.text = pickedFile.name;
      });
    } else {
      print('no image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    _textJumlahController.text = 500000.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran SPP'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
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
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
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
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
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
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                          controller: _textSemesterController,
                          decoration: InputDecoration(
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
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
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
                                color: Colors.deepPurple[200],
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                      enabled: false,
                      controller: _textBuktiController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      )),
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
                        onTap: () async {
                          bool response = await repository.postData(
                              _textNamaController.text,
                              _textKelasController.text,
                              _textSemesterController.text,
                              _textJumlahController.text,
                              _textBuktiController.text);

                          if (response) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Dashboard();
                                },
                              ),
                            );
                          } else {
                            print('Post data gagal');
                          }
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
    );
  }
}
