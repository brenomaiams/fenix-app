import 'package:flutter/material.dart';
import 'package:telaoficina/bd/conexao.dart';
import 'package:telaoficina/pages/cadastroClientes.dart';

class EditarCliente extends StatefulWidget {
  final ClienteDTO cliente;
  final Function(ClienteDTO) onUpdate;

  EditarCliente({required this.cliente, required this.onUpdate});

  @override
  _EditarClienteState createState() => _EditarClienteState();
}


class _EditarClienteState extends State<EditarCliente> {
  late TextEditingController _nomeController;
  late TextEditingController _cpfController;
  late TextEditingController _cepController;
  late TextEditingController _enderecoController;
  late TextEditingController _numeroCasaController;
  late TextEditingController _modeloController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.cliente.nome);
    _cpfController = TextEditingController(text: widget.cliente.cpf);
    _cepController = TextEditingController(text: widget.cliente.cep);
    _enderecoController = TextEditingController(text: widget.cliente.endereco);
    _numeroCasaController = TextEditingController(text: widget.cliente.numeroCasa);
    _modeloController = TextEditingController(text: widget.cliente.modelo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _cepController,
              decoration: InputDecoration(labelText: 'CEP'),
            ),
            TextField(
              controller: _enderecoController,
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            TextField(
              controller: _numeroCasaController,
              decoration: InputDecoration(labelText: 'Número da Casa'),
            ),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                ClienteDTO clienteEditado = ClienteDTO(
                  id: widget.cliente.id,
                  nome: _nomeController.text,
                  cpf: _cpfController.text,
                  cep: _cepController.text,
                  endereco: _enderecoController.text,
                  numeroCasa: _numeroCasaController.text,
                  modelo: _modeloController.text,
                );
                await Conexao.instance.updateCliente(clienteEditado);
                widget.onUpdate(clienteEditado);
                Navigator.pop(context);
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _cepController.dispose();
    _enderecoController.dispose();
    _numeroCasaController.dispose();
    _modeloController.dispose();
    super.dispose();
  }
}
