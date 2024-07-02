import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paml_inilast/models/studio.dart';

class StudioService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<Studio?> createStudio(Studio studio) async {
    try {
      final url = Uri.parse('$baseUrl/studio');
      print('Sending request to: $url');
      print('Request body: ${studio.toJson()}');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: studio.toJson(),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return Studio.fromJson(response.body);
      } else {
        print('Failed to create studio: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in createStudio: $e');
      return null;
    }
  }

  Future<List<Studio>> getStudios() async {
    try {
      final url = Uri.parse('$baseUrl/studio');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        print('API Response: $body'); // Debugging

        List<Studio> studios =
            body.map((dynamic item) => Studio.fromMap(item)).toList();
        return studios;
      } else {
        print('Failed to load studios: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error in getStudios: $e');
      return [];
    }
  }

  Future<Studio?> getStudioById(String id) async {
    try {
      final url = Uri.parse('$baseUrl/studio/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Studio.fromJson(response.body);
      } else {
        print('Failed to load studio: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in getStudioById: $e');
      return null;
    }
  }

  Future<bool> updateStudio(Studio studio, String id) async {
    try {
      final url = Uri.parse('$baseUrl/studio/$id');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: studio.toJson(),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error in updateStudio: $e');
      return false;
    }
  }

  Future<bool> deleteStudio(String id) async {
    try {
      final url = Uri.parse('$baseUrl/studio/$id');
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        print('Data berhasil dihapus');
        return true;
      } else {
        print('Gagal menghapus data: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error in deleteStudio: $e');
      return false;
    }
  }

  Future<bool> updateStatus(String id, String status) async {
    try {
      final url = Uri.parse('$baseUrl/studio/$id/status');
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
