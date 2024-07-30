import 'package:flutter/material.dart';
import 'package:restaurante_app/pages/front/home_page.dart';

void main() {
  runApp(MyApp());
}

//TODO - modularizar arquivos de imagem em módulo própio
//TODO - falta o read, update, e delete dos arquivos de imagem

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
