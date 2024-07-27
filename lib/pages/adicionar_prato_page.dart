import 'package:flutter/material.dart';
import 'package:restaurante_app/services/api_service.dart';

class AdicionarPratoPage extends StatefulWidget {
  @override
  _AdicionarPratoPageState createState() => _AdicionarPratoPageState();
}

class _AdicionarPratoPageState extends State<AdicionarPratoPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController precoController = TextEditingController();

  Future<void> adicionarPrato() async {
    try {
      final nome = nomeController.text;
      final preco = precoController.text;
      final response = await ApiService.adicionarPrato(nome, preco);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Prato adicionado')));
        nomeController.clear();
        precoController.clear();
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add prato')));
      throw Exception('Failed to add prato');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Prato'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome do Prato'),
            ),
            TextField(
              controller: precoController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: adicionarPrato,
              child: Text('Adicionar Prato'),
            ),
          ],
        ),
      ),
    );
  }
}
