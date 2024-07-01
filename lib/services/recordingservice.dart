import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paml_inilast/models/recording.dart';

class RecordingService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<Recording?> createRecording(Recording recording) async {
    try {
      final url = Uri.parse('$baseUrl/recordings');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(recording.toMap()),
      );

      if (response.statusCode == 201) {
        return Recording.fromJson(response.body);
      } else {
        print('Failed to create recording: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in createRecording: $e');
      return null;
    }
  }

  Future<List<Recording>> getRecordings() async {
    try {
      final url = Uri.parse('$baseUrl/recordings');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Recording> recordings =
            body.map((dynamic item) => Recording.fromMap(item)).toList();
        return recordings;
      } else {
        print('Failed to load recordings: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error in getRecordings: $e');
      return [];
    }
  }

  Future<Recording?> getRecordingById(String id) async {
    try {
      final url = Uri.parse('$baseUrl/recordings/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Recording.fromJson(response.body);
      } else {
        print('Failed to load recording: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in getRecordingById: $e');
      return null;
    }
  }

  Future<bool> updateRecording(Recording recording, String id) async {
    try {
      final url = Uri.parse('$baseUrl/recordings/$id');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(recording.toMap()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error in updateRecording: $e');
      return false;
    }
  }

  Future<bool> deleteRecording(String id) async {
  try {
    final url = Uri.parse('$baseUrl/recordings/$id');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      print('Data berhasil dihapus');
      return true;
    } else {
      print('Gagal menghapus data: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error in deleteRecording: $e');
    return false;
  }
}

}
