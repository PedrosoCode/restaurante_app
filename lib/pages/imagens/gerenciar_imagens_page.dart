import 'package:flutter/material.dart';
import 'package:restaurante_app/pages/imagens/criar_imagem_page.dart';
import 'package:restaurante_app/pages/imagens/listar_imagens_page.dart';

//FIXME - quando faz o upload de imagem grande demais, ocorre um overflow e se perde visão dos controladores

class GerenciarImagensPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Imagens'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CriarImagemPage()),
                );
              },
              child: Text('Criar Imagem'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListarImagensPage()),
                );
              },
              child: Text('Listar Imagens'),
            ),
          ],
        ),
      ),
    );
  }
}
