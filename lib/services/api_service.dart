import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<List<dynamic>> getPratos() async {
    final response = await http.get(Uri.parse('$baseUrl/pratos'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pratos');
    }
  }

  static Future<http.Response> adicionarPrato(String nome, String preco) async {
    final response = await http.post(
      Uri.parse('$baseUrl/adicionar_prato'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'nome': nome, 'preco': preco},
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return http.Response('Prato adicionado', response.statusCode);
    } else {
      throw Exception('Failed to add prato');
    }
  }
}
