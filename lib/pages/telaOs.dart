import 'package:flutter/material.dart';
import 'package:telaoficina/pages/Telainicial.dart'; //
import 'package:telaoficina/pages/Telainicial.dart';

class telaOS extends StatefulWidget {
  const telaOS({Key? key}) : super(key: key);

  @override
  State<telaOS> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<telaOS> {
  List<DataRow> _rows = [];
  final TextEditingController _nomeClienteController = TextEditingController();
  final TextEditingController _placaCarroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ordem de Serviço',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushNamed(context, '/tela4');
          },
        ),
        backgroundColor: Color(0xFF333333),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nomeClienteController,
                decoration: InputDecoration(
                  labelText: 'Nome do Cliente',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _placaCarroController,
                decoration: InputDecoration(
                  labelText: 'Placa do Carro',
                  prefixIcon: Icon(Icons.directions_car),
                ),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('QNDT')),
                DataColumn(label: Text('DESCRIÇÃO DO SERVIÇO')),
                DataColumn(label: Text('VALOR')),
              ],
              rows: _rows,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarLinha,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _adicionarLinha() {
    setState(() {
      _rows.add(DataRow(cells: [
        DataCell(TextField()),
        DataCell(TextField()),
        DataCell(TextField()),
      ]));
    });
  }

  @override
  void dispose() {
    _nomeClienteController.dispose();
    _placaCarroController.dispose();
    super.dispose();
  }
}