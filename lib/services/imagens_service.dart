import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ImagensService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<http.Response> uploadImagem(File imageFile, String nome) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/imagens/upload'));
    request.fields['nome'] = nome;
    request.files
        .add(await http.MultipartFile.fromPath('imagem', imageFile.path));
    var response = await request.send();

    var responseBody = await http.Response.fromStream(response);
    print('Response status: ${responseBody.statusCode}');
    print('Response body: ${responseBody.body}');
    if (responseBody.statusCode == 200) {
      return http.Response('Imagem adicionada', responseBody.statusCode);
    } else {
      throw Exception('Failed to add image');
    }
  }
}
