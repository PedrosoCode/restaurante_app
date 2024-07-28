import 'package:http/http.dart' as http;
import 'dart:convert';

class PratosService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<List<dynamic>> getPratos() async {
    final response = await http.get(Uri.parse('$baseUrl/pratos/'));
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
      Uri.parse('$baseUrl/pratos/adicionar'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: 'nome=$nome&preco=$preco',
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return http.Response('Prato adicionado', response.statusCode);
    } else {
      throw Exception('Failed to add prato');
    }
  }

  static Future<http.Response> deletarPrato(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/pratos/deletar/$id'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return http.Response('Prato deletado', response.statusCode);
    } else {
      throw Exception('Failed to delete prato');
    }
  }

  static Future<http.Response> atualizarPrato(
      int id, String nome, String preco) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pratos/atualizar/$id'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: 'nome=$nome&preco=$preco',
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return http.Response('Prato atualizado', response.statusCode);
    } else {
      throw Exception('Failed to update prato');
    }
  }
}
