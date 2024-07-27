import 'package:flutter/material.dart';
import 'package:restaurante_app/services/api_service.dart';

class ListarPratosPage extends StatefulWidget {
  @override
  _ListarPratosPageState createState() => _ListarPratosPageState();
}

class _ListarPratosPageState extends State<ListarPratosPage> {
  List<Map<String, dynamic>> pratos = [];

  @override
  void initState() {
    super.initState();
    fetchPratos();
  }

  Future<void> fetchPratos() async {
    try {
      final response = await ApiService.getPratos();
      setState(() {
        pratos = List<Map<String, dynamic>>.from(response.map((prato) => {
              'id': prato['id'] ?? '',
              'nome': prato['nome'] ?? '',
              'preco': prato['preco'] ?? '',
            }));
      });
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load pratos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Pratos'),
      ),
      body: ListView.builder(
        itemCount: pratos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pratos[index]['nome'] ?? 'Nome não disponível'),
            subtitle: Text(
                'Preço: ${pratos[index]['preco'] ?? 'Preço não disponível'}'),
          );
        },
      ),
    );
  }
}
