import 'package:flutter/material.dart';
import 'package:telaoficina/bd/conexao.dart';
import 'package:telaoficina/cores/minhasCores.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class CadastroClientes extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController numeroCasaController = TextEditingController();
  final TextEditingController placaCarroController = TextEditingController();
  final TextEditingController modeloController = TextEditingController();
  CadastroClientes({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MinhasCores.vermelhoescuro,
        title: Center(
          child: Text('Cadastro de Clientes',
          style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: cepController,
              decoration: InputDecoration(labelText: 'CEP'),
            ),
            TextField(
              controller: enderecoController,
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            TextField(
              controller: numeroCasaController,
              decoration: InputDecoration(labelText: 'Número da Casa'),
            ),
            TextField(
              controller: placaCarroController,
              decoration: InputDecoration(labelText: 'Placa do Carro'),
            ),
            TextField(
              controller: modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            SizedBox(height: 100),
      ElevatedButton(
        onPressed: () async {
          await Conexao.instance.database.then((db) {
            db.insert(Conexao.table, {
              Conexao.columnNome: nomeController.text,
              Conexao.columnCpf: cpfController.text,
              Conexao.columnCep: cepController.text,
              Conexao.columnEndereco: enderecoController.text,
              Conexao.columnNumeroCasa: int.tryParse(numeroCasaController.text) ?? 0,
              Conexao.columnPlaca: placaCarroController.text,
              Conexao.columnModelo: modeloController.text,
            }).then((value) {
              print(('Deu certo enviar ao Banco!'));
            });
          });
        },
        child: Text('SALVAR',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

     ])));
  }
}
