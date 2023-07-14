import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:manajemen_spp/dashboard.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:manajemen_spp/repository.dart';
import 'package:manajemen_spp/models.dart';
import 'package:http/http.dart' as http;
import 'package:manajemen_spp/profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Siswa> listSiswa = [];
  Repository repositorySiswa = Repository();
  final _textNamaController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textKelasController = TextEditingController();
  final _textSemesterController = TextEditingController();
  final _textNisController = TextEditingController();
  final _textTtlController = TextEditingController();
  final _textAlamatController = TextEditingController();
  final _textWaliKelasController = TextEditingController();
  final _textAyahController = TextEditingController();
  final _textPekerjaanAyahController = TextEditingController();
  final _textIbuController = TextEditingController();
  final _textPekerjaanIbuController = TextEditingController();
  final _textNoHpController = TextEditingController();

  File? image;
  final _picker = ImagePicker();

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
    getDataSiswa();
  }

  Future<bool> patchData(
      int id,
      String nama,
      String email,
      String kelas,
      String semester,
      String nis,
      String ttl,
      String alamat,
      String wali_kelas,
      String ayah,
      String pekerjaan_ayah,
      String ibu,
      String pekerjaan_ibu,
      String no_hp,
      String imagePath) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('http://192.168.212.32:5000/siswa/$id'),
      );

      request.fields['nama'] = nama;
      request.fields['email'] = email;
      request.fields['kelas'] = kelas;
      request.fields['semester'] = semester;
      request.fields['nis'] = nis;
      request.fields['ttl'] = ttl;
      request.fields['alamat'] = alamat;
      request.fields['wali_kelas'] = wali_kelas;
      request.fields['ayah'] = ayah;
      request.fields['pekerjaan_ayah'] = pekerjaan_ayah;
      request.fields['ibu'] = ibu;
      request.fields['pekerjaan_ibu'] = pekerjaan_ibu;
      request.fields['no_hp'] = no_hp;

      if (imagePath.isNotEmpty) {
        var file = await http.MultipartFile.fromPath('file', imagePath);
        request.files.add(file);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
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

    if (listSiswa.isNotEmpty) {
      _textNamaController.text =
          listSiswa[0].nama; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textEmailController.text =
          listSiswa[0].email; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textKelasController.text =
          listSiswa[0].kelas; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textSemesterController.text = listSiswa[0]
          .semester; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textNisController.text =
          listSiswa[0].nis; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textTtlController.text =
          listSiswa[0].ttl; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textAlamatController.text =
          listSiswa[0].alamat; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textWaliKelasController.text = listSiswa[0]
          .wali_kelas; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textAyahController.text =
          listSiswa[0].ayah; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textPekerjaanAyahController.text = listSiswa[0]
          .pekerjaan_ayah; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textIbuController.text =
          listSiswa[0].ibu; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textPekerjaanIbuController.text = listSiswa[0]
          .pekerjaan_ibu; // Mengisi nilai nama siswa dari API ke textfield
    }
    if (listSiswa.isNotEmpty) {
      _textNoHpController.text =
          listSiswa[0].no_hp; // Mengisi nilai nama siswa dari API ke textfield
    }

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 34, 31, 38),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 53, 17, 110),
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
                                    ?.copyWith(color: Colors.white)),
                            subtitle: Text('SMAN 1 WATES',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white54)),
                            trailing: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(url + siswa.image),
                            ),
                          ),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 53, 17, 110),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, right: 30, left: 30),
                      child: Text(
                        'Edit Data Profile Siswa',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Ganti Poto Profile',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 27.0),
                        child: Text(
                          'Nama :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 107.0),
                        child: Text(
                          'Email :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 57, 44, 89),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                enabled: false,
                                controller: _textNamaController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nama',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 40,
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
                                controller: _textEmailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 27.0),
                        child: Text(
                          'Kelas :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 112.0),
                        child: Text(
                          'Semester :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 57, 44, 89),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                enabled: false,
                                controller: _textKelasController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Kelas',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 57, 44, 89),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                enabled: false,
                                controller: _textSemesterController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Semester',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 27.0),
                        child: Text(
                          'NIS :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 129.0),
                        child: Text(
                          'Wali Kelas :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 57, 44, 89),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                enabled: false,
                                controller: _textNisController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nis',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 57, 44, 89),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                enabled: false,
                                controller: _textWaliKelasController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Wali Kelas',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 27.0),
                        child: Text(
                          'Alamat :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 97.0),
                        child: Text(
                          'No Hp :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 88, 52, 169),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: _textAlamatController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Alamat',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 88, 52, 169),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: _textNoHpController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'No Hp',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 27.0),
                        child: Text(
                          'Nama Ayah :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 58.0),
                        child: Text(
                          'Pekerjaan Ayah :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 88, 52, 169),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: _textAyahController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nama Ayah',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 88, 52, 169),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: _textPekerjaanAyahController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Pekerjaan Ayah',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 27.0),
                        child: Text(
                          'Nama Ibu :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 74.0),
                        child: Text(
                          'Pekerjaan Ibu :',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 88, 52, 169),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: _textIbuController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nama Ibu',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 88, 52, 169),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: _textPekerjaanIbuController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Pekerjaan Ibu',
                                  contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 153),
                    child: Text(
                      'Tempat Tanggal Lahir :',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      height: 40, 
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 88, 52, 169),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                            controller: _textTtlController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tempat Tanggal Lahir',
                              contentPadding: EdgeInsets.only(left: -10, bottom: 8)
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: GestureDetector(
                          onTap: () {
                            String nama = _textNamaController.text;
                            String email = _textEmailController.text;
                            String kelas = _textKelasController.text;
                            String semester = _textSemesterController.text;
                            String nis = _textNisController.text;
                            String ttl = _textTtlController.text;
                            String alamat = _textAlamatController.text;
                            String wali_kelas = _textWaliKelasController.text;
                            String ayah = _textAyahController.text;
                            String pekerjaan_ayah =
                                _textPekerjaanAyahController.text;
                            String ibu = _textIbuController.text;
                            String pekerjaan_ibu =
                                _textPekerjaanIbuController.text;
                            String no_hp = _textNoHpController.text;
                            String imagePath =
                                ''; // Gunakan gambar yang ada sebelumnya sebagai nilai default

                            if (image != null) {
                              imagePath =
                                  image!.path; // Gunakan gambar baru jika ada
                            }

                            patchData(
                                    listSiswa[0].id,
                                    nama,
                                    email,
                                    kelas,
                                    semester,
                                    nis,
                                    ttl,
                                    alamat,
                                    wali_kelas,
                                    ayah,
                                    pekerjaan_ayah,
                                    ibu,
                                    pekerjaan_ibu,
                                    no_hp,
                                    imagePath)
                                .then((success) {
                              if (success) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Pesan'),
                                      content: Text('Data berhasil diperbarui'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return MyProfile();
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
                                      content: Text('Gagal memperbarui data'),
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
                                left: 58, right: 58, top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Update',
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
                                  return MyProfile();
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
                  SizedBox(
                    height: 15,
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
