import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paml_inilast/models/alatmusik.dart';

class Alatservice {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<Alatmusik?> createAlat(Alatmusik alatmusik) async {
    try {
      final url = Uri.parse('$baseUrl/alatmusik');
      print('Sending request to: $url');
      print('Request body: ${alatmusik.toJson()}');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(alatmusik.toMap()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return Alatmusik.fromJson(response.body);
      } else {
        print('Failed to create alatmusik: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in createAlatmusik: $e');
      return null;
    }
  }

  Future<List<Alatmusik>> getAlats() async {
    try {
      final url = Uri.parse('$baseUrl/alatmusik');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        print('API Response: $body'); // Debugging

        List<Alatmusik> alatmusiks =
            body.map((dynamic item) => Alatmusik.fromMap(item)).toList();
        return alatmusiks;
      } else {
        print('Failed to load alatmusiks: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error in getAlats: $e');
      return [];
    }
  }

  Future<Alatmusik?> getAlatById(String id) async {
    try {
      final url = Uri.parse('$baseUrl/alatmusik/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Alatmusik.fromJson(response.body);
      } else {
        print('Failed to load alatmusik: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in getAlatById: $e');
      return null;
    }
  }

  Future<bool> updateAlat(Alatmusik alatmusik, String id) async {
    try {
      final url = Uri.parse('$baseUrl/alatmusik/$id');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(alatmusik.toMap()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error in updateAlat: $e');
      return false;
    }
  }

  Future<bool> deleteAlat(String id) async {
    try {
      final url = Uri.parse('$baseUrl/alatmusik/$id');
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        print('Data berhasil dihapus');
        return true;
      } else {
        print('Gagal menghapus data: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error in deleteAlat: $e');
      return false;
    }
  }
  Future<bool> updateStatus(String id, String status) async {
    try {
      final url = Uri.parse('$baseUrl/alatmusik/$id/status');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update status: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error in updateStatus: $e');
      return false;
    }
  }
}
