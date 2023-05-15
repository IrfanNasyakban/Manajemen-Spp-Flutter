import 'dart:async';
import 'dart:convert';
import 'package:manajemen_spp/models.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _baseUrl = 'https://645a0ae165bd868e930ef4d8.mockapi.io';

  Future<List<Siswa>> getData() async {
    final response = await http.get(Uri.parse(_baseUrl + '/siswa'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Siswa.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
