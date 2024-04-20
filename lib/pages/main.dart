import 'package:flutter/material.dart';
import 'package:telaoficina/pages/Telainicial.dart';
import 'package:telaoficina/pages/cadastroClientes.dart';
import 'package:telaoficina/pages/checklist.dart';
import 'package:telaoficina/pages/menu.dart';
import 'package:telaoficina/pages/telaOs.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => Telainicial(),
        '/tela2' : (context) => telaChecklist(),
        '/tela3' : (context) => telaOS(),
        '/tela4' : (context) => Menu(),
        '/tela5' : (context) => CadastroClientes(),
      },
    );
  }}
