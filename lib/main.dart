import 'package:flutter/material.dart';
import 'package:telaoficina/bd/conexao.dart';
import 'package:telaoficina/pages/tela_inicial.dart';
import 'package:telaoficina/pages/cadastro_clientes.dart';
import 'package:telaoficina/pages/checklist.dart';
import 'package:telaoficina/pages/menu.dart';
import 'package:telaoficina/pages/tela_os.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Conexao.instance.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> clientes = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => TelaInicial(),
        '/tela2': (context) => TelaChecklist(),
        '/tela3': (context) => TelaOs(),
        '/tela4': (context) => Menu(),
        '/tela5': (context) => CadastroClientes(),
      },
    );
  }
}
