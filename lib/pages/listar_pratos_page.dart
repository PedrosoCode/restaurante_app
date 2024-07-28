import 'package:flutter/material.dart';
import 'package:restaurante_app/services/pratos_service.dart';

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
      final response = await PratosService.getPratos();
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

  Future<void> adicionarPrato(String nome, String preco) async {
    try {
      await PratosService.adicionarPrato(nome, preco);
      fetchPratos(); // Atualiza a lista de pratos após a adição
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to add prato');
    }
  }

  Future<void> deletarPrato(int id) async {
    try {
      await PratosService.deletarPrato(id);
      fetchPratos(); // Atualiza a lista de pratos após a exclusão
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to delete prato');
    }
  }

  Future<void> atualizarPrato(int id, String nome, String preco) async {
    try {
      await PratosService.atualizarPrato(id, nome, preco);
      fetchPratos(); // Atualiza a lista de pratos após a atualização
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to update prato');
    }
  }

  void showAddPratoDialog() {
    TextEditingController nomeController = TextEditingController();
    TextEditingController precoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Prato'),
        content: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(hintText: 'Nome do Prato'),
            ),
            TextField(
              controller: precoController,
              decoration: InputDecoration(hintText: 'Preço do Prato'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (nomeController.text.isNotEmpty &&
                  precoController.text.isNotEmpty) {
                adicionarPrato(nomeController.text, precoController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void showUpdatePratoDialog(int id, String currentNome, String currentPreco) {
    TextEditingController nomeController =
        TextEditingController(text: currentNome);
    TextEditingController precoController =
        TextEditingController(text: currentPreco);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Atualizar Prato'),
        content: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(hintText: 'Nome do Prato'),
            ),
            TextField(
              controller: precoController,
              decoration: InputDecoration(hintText: 'Preço do Prato'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (nomeController.text.isNotEmpty &&
                  precoController.text.isNotEmpty) {
                atualizarPrato(id, nomeController.text, precoController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Atualizar'),
          ),
        ],
      ),
    );
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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: showAddPratoDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pratos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(pratos[index]['nome'] ?? 'Nome não disponível'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => showUpdatePratoDialog(
                          pratos[index]['id'],
                          pratos[index]['nome'],
                          pratos[index]['preco']),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          showDeleteConfirmationDialog(pratos[index]['id']),
                    ),
                  ],
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
