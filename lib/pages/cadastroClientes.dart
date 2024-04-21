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
              decoration: InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextField(
              controller: cpfController,
              decoration: InputDecoration(
                labelText: 'CPF',
                prefixIcon: Icon(Icons.credit_card),
              ),
            ),
            TextField(
              controller: cepController,
              decoration: InputDecoration(
                labelText: 'CEP',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            TextField(
              controller: enderecoController,
              decoration: InputDecoration(
                labelText: 'Endereço',
                prefixIcon: Icon(Icons.home),
              ),
            ),
            TextField(
              controller: numeroCasaController,
              decoration: InputDecoration(
                labelText: 'Número da Casa',
                prefixIcon: Icon(Icons.home),
              ),
            ),
            TextField(
              controller: placaCarroController,
              decoration: InputDecoration(
                labelText: 'Placa do Carro',
                prefixIcon: Icon(Icons.directions_car),
              ),
            ),
            TextField(
              controller: modeloController,
              decoration: InputDecoration(
                labelText: 'Modelo',
                prefixIcon: Icon(Icons.engineering),
              ),
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
                    print(('Dados salvos no Banco!'));
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
          ],
        ),));
  }
}
