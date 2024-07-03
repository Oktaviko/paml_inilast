import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paml_inilast/models/instrumen.dart';

class InstrumenService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<Instrumen?> createInstrumen(Instrumen instrumen) async {
    try {
      final url = Uri.parse('$baseUrl/instrumen');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: instrumen.toJson(),
      );

      if (response.statusCode == 201) {
        return Instrumen.fromJson(response.body);
      } else {
        print('Failed to create instrumen: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in createInstrumen: $e');
      return null;
    }
  }

  Future<List<Instrumen>> getInstrumens() async {
    try {
      final url = Uri.parse('$baseUrl/instrumen');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Instrumen> instrumens =
            body.map((dynamic item) => Instrumen.fromMap(item)).toList();
        return instrumens;
      } else {
        print('Failed to load instrumens: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error in getInstrumens: $e');
      return [];
    }
  }

  Future<Instrumen?> getInstrumenById(String id) async {
    try {
      final url = Uri.parse('$baseUrl/instrumen/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return Instrumen.fromJson(response.body);
      } else {
        print('Failed to load instrumen: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error in getInstrumenById: $e');
      return null;
    }
  }

  Future<bool> updateInstrumen(Instrumen instrumen, String id) async {
    try {
      final url = Uri.parse('$baseUrl/instrumen/$id');
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: instrumen.toJson(),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error in updateInstrumen: $e');
      return false;
    }
  }

  Future<bool> deleteInstrumen(String id) async {
    try {
      final url = Uri.parse('$baseUrl/instrumen/$id');
      final response = await http.delete(url);

      return response.statusCode == 204;
    } catch (e) {
      print('Error in deleteInstrumen: $e');
      return false;
    }
  }
}
