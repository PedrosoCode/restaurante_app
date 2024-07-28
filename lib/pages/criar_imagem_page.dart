import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:restaurante_app/services/imagens_service.dart';

//TODO - condicionar para selecionar tags no momento da criação de imagens

class CriarImagemPage extends StatefulWidget {
  @override
  _CriarImagemPageState createState() => _CriarImagemPageState();
}

class _CriarImagemPageState extends State<CriarImagemPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final TextEditingController _nomeController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null || _nomeController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Preencha todos os campos')));
      return;
    }

    try {
      final response = await ImagensService.uploadImagem(
        File(_imageFile!.path),
        _nomeController.text,
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Imagem adicionada')));
        _nomeController.clear();
        setState(() {
          _imageFile = null;
        });
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Imagem'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome da Imagem'),
            ),
            SizedBox(height: 20),
            _imageFile == null
                ? Text('Nenhuma imagem selecionada.')
                : Image.file(File(_imageFile!.path)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Selecionar Imagem'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Imagem'),
            ),
          ],
        ),
      ),
    );
  }
}
