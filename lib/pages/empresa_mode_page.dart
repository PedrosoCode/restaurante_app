import 'package:flutter/material.dart';
import 'package:restaurante_app/pages/listar_pratos_page.dart';
import 'package:restaurante_app/pages/adicionar_prato_page.dart';

class EmpresaModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modo Empresa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListarPratosPage()),
                );
              },
              child: Text('Listar Pratos'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdicionarPratoPage()),
                );
              },
              child: Text('Adicionar Prato'),
            ),
          ],
        ),
      ),
    );
  }
}
