import 'package:flutter/material.dart';
import 'package:telaoficina/bd/conexao.dart';
import 'package:telaoficina/pages/Telainicial.dart';
import 'package:telaoficina/pages/cadastroClientes.dart';
import 'package:telaoficina/pages/checklist.dart';
import 'package:telaoficina/pages/menu.dart';
import 'package:telaoficina/pages/telaOs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Conexao.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> clientes = [];


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
  }
}
