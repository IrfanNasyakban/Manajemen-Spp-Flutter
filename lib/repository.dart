import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manajemen_spp/models.dart';
import 'package:http/http.dart' as http;


class Repository {
  final user = FirebaseAuth.instance.currentUser!;
  
  final _baseUrl = 'https://645a0ae165bd868e930ef4d8.mockapi.io';

  Future<List<Siswa>> getData() async {
    String userEmail = user.email!;
    String username;

    if (userEmail == 'irfan@gmail.com') {
      username = 'Irvan Nasyakban';
    } else if (userEmail == 'ari@gmail.com') {
      username = 'Muhammad Ariansyah';
    } else if (userEmail == 'widia@gmail.com') {
      username = 'Widia Hamsi';
    } else {
      username = 'Fannisa Nadhira';
    }
    
    final response = await http.get(Uri.parse(_baseUrl + '/siswa'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<Siswa> siswaList = responseData
          .map((json) => Siswa.fromJson(json))
          .where((siswa) => siswa.nama == username)
          .toList();
      return siswaList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

class RepositoryImage {
  final user = FirebaseAuth.instance.currentUser!;
  final _baseUrl = 'https://645a0ae165bd868e930ef4d8.mockapi.io';

  Future<List<ImageData>> getData() async {
    String userEmail = user.email!;
    String username;

    if (userEmail == 'irfan@gmail.com') {
      username = 'Irvan Nasyakban';
    } else if (userEmail == 'ari@gmail.com') {
      username = 'Muhammad Ariansyah';
    } else if (userEmail == 'widia@gmail.com') {
      username = 'Widia Hamsi';
    } else {
      username = 'Fannisa Nadhira';
    }
    
    final response = await http.get(Uri.parse(_baseUrl + '/transaksi'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<ImageData> imageList = responseData
          .map((json) => ImageData.fromJson(json))
          .where((image) => image.nama == username)
          .toList();
      return imageList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future postData(
      String nama, String kelas, String semester, String jumlah, String bukti) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl + '/transaksi'),
          body: {
            "nama": nama,
            "kelas": kelas,
            "semester": semester,
            "jumlah": jumlah,
            "bukti": bukti
          });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}