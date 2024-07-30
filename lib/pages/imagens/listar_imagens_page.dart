import 'package:flutter/material.dart';
import 'package:restaurante_app/services/imagens_service.dart';

class ListarImagensPage extends StatefulWidget {
  @override
  _ListarImagensPageState createState() => _ListarImagensPageState();
}

class _ListarImagensPageState extends State<ListarImagensPage> {
  Future<List<dynamic>>? _imagensFuture;

  @override
  void initState() {
    super.initState();
    _imagensFuture = ImagensService.listarImagens();
  }

  void _editarImagem(int id, String nome) async {
    TextEditingController _nomeController = TextEditingController(text: nome);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Imagem'),
          content: TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome da Imagem'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await ImagensService.editarImagem(id, _nomeController.text);
                setState(() {
                  _imagensFuture = ImagensService.listarImagens();
                });
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirImagem(int id) async {
    await ImagensService.excluirImagem(id);
    setState(() {
      _imagensFuture = ImagensService.listarImagens();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Imagens'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _imagensFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar imagens'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma imagem encontrada'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var imagem = snapshot.data![index];
                return ListTile(
                  title: Text(imagem['nome']),
                  subtitle: Text(imagem['caminho']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editarImagem(imagem['id'], imagem['nome']);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _excluirImagem(imagem['id']);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
