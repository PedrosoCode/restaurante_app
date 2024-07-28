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

  Future<void> deletarPrato(int id) async {
    try {
      await ApiService.deletarPrato(id);
      fetchPratos(); // Atualiza a lista de pratos após a exclusão
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to delete prato');
    }
  }

  void showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Você tem certeza que deseja excluir este prato?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              deletarPrato(id);
              Navigator.of(context).pop();
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(pratos[index]['nome'] ?? 'Nome não disponível'),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      showDeleteConfirmationDialog(pratos[index]['id']),
                ),
              ],
            ),
            subtitle: Text(
                'Preço: ${pratos[index]['preco'] ?? 'Preço não disponível'}'),
          );
        },
      ),
    );
  }
}
