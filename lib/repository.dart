import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manajemen_spp/models.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class Repository {
  final user = FirebaseAuth.instance.currentUser!;

  final _baseUrl = 'http://192.168.51.32:5000';

  Future<List<Siswa>> getDataSiswa() async {
    String userEmail = user.email!;
    String username;

    if (userEmail == '210180187@siswa.ac.id') {
      username = 'Irvan Nasyakban';
    } else if (userEmail == '210180197@siswa.ac.id') {
      username = 'Muhammad Ariansyah';
    } else if (userEmail == '210180184@siswa.ac.id') {
      username = 'Widia Hamsi';
    } else {
      username = 'Fannisa Nadira';
    }

    try {
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
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to fetch data');
    }
  }
}

// Transaksi
class RepositoryBayar {
  final user = FirebaseAuth.instance.currentUser!;
  final _baseUrl = 'http://192.168.51.32:5000';

  Future<List<Bayar>> getData() async {
    String userEmail = user.email!;
    String username;

    if (userEmail == '210180187@siswa.ac.id') {
      username = 'Irvan Nasyakban';
    } else if (userEmail == '210180197@siswa.ac.id') {
      username = 'Muhammad Ariansyah';
    } else if (userEmail == '210180184@siswa.ac.id') {
      username = 'Widia Hamsi';
    } else {
      username = 'Fannisa Nadira';
    }

    final response = await http.get(Uri.parse(_baseUrl + '/bayar'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<Bayar> bayarList = responseData
          .map((json) => Bayar.fromJson(json))
          .where((bayar) => bayar.nama == username)
          .toList();
      return bayarList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
