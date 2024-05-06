import 'package:flutter/material.dart';
import 'package:telaoficina/bd/conexao.dart';
import 'package:telaoficina/pages/cadastroClientes.dart';
import 'package:telaoficina/pages/editar_cliente.dart';

class DetalhesCliente extends StatefulWidget {
  ClienteDTO cliente;

  DetalhesCliente({required this.cliente});

  @override
  _DetalhesClienteState createState() => _DetalhesClienteState();
}

class _DetalhesClienteState extends State<DetalhesCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Cliente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${widget.cliente.nome}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'CPF: ${widget.cliente.cpf}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'CEP: ${widget.cliente.cep}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Endereço: ${widget.cliente.endereco}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Número da Casa: ${widget.cliente.numeroCasa}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Modelo: ${widget.cliente.modelo}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final ClienteDTO? clienteEditado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarCliente(
                      cliente: widget.cliente, // Corrigido aqui
                      onUpdate: (ClienteDTO cliente) {
                        // Atualize a lista de clientes aqui
                        setState(() {
                          widget.cliente.nome = cliente.nome;
                          widget.cliente.cpf = cliente.cpf;
                          widget.cliente.cep = cliente.cep;
                          widget.cliente.endereco = cliente.endereco;
                          widget.cliente.numeroCasa = cliente.numeroCasa;
                          widget.cliente.modelo = cliente.modelo;
                        });
                      },
                    ),
                  ),
                );

                if (clienteEditado != null) {
                  // Atualize o cliente na lista de clientes
                  setState(() {
                    widget.cliente = clienteEditado;
                  });
                }
              },
              child: Text('Editar Cliente'),
            ),
          ],
        ),
      ),
    );
  }
}
