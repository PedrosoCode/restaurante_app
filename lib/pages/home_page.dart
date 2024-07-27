import 'package:flutter/material.dart';
import 'package:restaurante_app/pages/empresa_mode_page.dart';
import 'package:restaurante_app/pages/usuario_mode_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurante App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmpresaModePage()),
                );
              },
              child: Text('Modo Empresa'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsuarioModePage()),
                );
              },
              child: Text('Modo Usuário'),
            ),
          ],
        ),
      ),
    );
  }
}
