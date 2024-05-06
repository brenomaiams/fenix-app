import 'package:flutter/material.dart';
import 'package:telaoficina/bd/conexao.dart';
import 'package:telaoficina/cores/minhasCores.dart';
import 'package:telaoficina/pages/detalhes_cliente.dart';
class ClienteDTO {
  int? id;
  String nome;
  String cpf;
  String cep;
  String endereco;
  String numeroCasa;
  String modelo;

  ClienteDTO({
    this.id,
    required this.nome,
    required this.cpf,
    required this.cep,
    required this.endereco,
    required this.numeroCasa,
    required this.modelo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'cep': cep,
      'endereco': endereco,
      'numeroCasa': numeroCasa,
      'modelo': modelo,
    };
  }

  static ClienteDTO fromMap(Map<String, dynamic> map) {
    return ClienteDTO(
      id: map['id'],
      nome: map['nome'],
      cpf: map['cpf'],
      cep: map['cep'],
      endereco: map['endereco'],
      numeroCasa: map['numeroCasa'] ?? '',
      modelo: map['modelo'],
    );
  }
}

class CadastroClientes extends StatefulWidget {
  const CadastroClientes({Key? key}) : super(key: key);

  @override
  _CadastroClientesState createState() => _CadastroClientesState();
}

class _CadastroClientesState extends State<CadastroClientes> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController numeroCasaController = TextEditingController();
  final TextEditingController modeloController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Conexao.instance.init();
  }

  Future<void> _saveCliente() async {
  ClienteDTO clienteDTO = ClienteDTO(
    id: null,
    nome: nomeController.text,
    cpf: cpfController.text,
    cep: cepController.text,
    endereco: enderecoController.text,
    numeroCasa: numeroCasaController.text, // Aqui o valor atualizado é passado
    modelo: modeloController.text,
  );


  print('Numero Casa: ${clienteDTO.numeroCasa}');
  print('ClienteDTO antes da inserção: ${clienteDTO.toMap()}');




  final db = Conexao.instance.database;
  final dbClient = await db;
  await dbClient.insert(Conexao.table, clienteDTO.toMap());

  print("Cliente salvo com sucesso");

  Inicio? inicio = context.findAncestorWidgetOfExactType<Inicio>();
  if (inicio != null) {
    await inicio.updateClientesList();
  }

  setState(() {
    nomeController.clear();
    cpfController.clear();
    cepController.clear();
    enderecoController.clear();
    numeroCasaController.clear();
    modeloController.clear();
  });
}


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cadastro de Clientes',
            style: TextStyle(fontSize: 24),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.add),
                text: 'Cadastro',
              ),
              Tab(
                icon: Icon(Icons.home),
                text: 'Clientes',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: EdgeInsets.all(20),
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: cpfController,
                  decoration: InputDecoration(labelText: 'CPF'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: cepController,
                  decoration: InputDecoration(labelText: 'CEP'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: enderecoController,
                  decoration: InputDecoration(labelText: 'Endereço'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: numeroCasaController,
                  decoration: InputDecoration(labelText: 'Número da Casa'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: modeloController,
                  decoration: InputDecoration(labelText: 'Modelo'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveCliente,
                  child: Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Conexao.instance.deleteAllClientes();
                    Inicio? inicio =
                        context.findAncestorWidgetOfExactType<Inicio>();
                    if (inicio != null) {
                      await inicio.updateClientesList();
                    }
                  },
                  child: Text('Apagar todos os clientes'),
                )
              ],
            ),
            Inicio(),
          ],
        ),
      ),
    );
  }
}


class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();

  void updateCliente(ClienteDTO cliente) {}
  
  updateClientesList() {}
}

class _InicioState extends State<Inicio> {
  List<ClienteDTO> clientes = [];

  @override
  void initState() {
    super.initState();
    Conexao.instance.init();
    updateClientesList();
  }

  Future<void> updateClientesList() async {
    final db = await Conexao.instance.database;

    if (db != null) {
      List<ClienteDTO> clientesList = await Conexao.instance.getAllClientes();

      setState(() {
        clientes = clientesList;
      });
    }
  }

  Future<void> _deleteCliente(int? id) async {
    await Conexao.instance.deleteCliente(id);
    await updateClientesList();
  }

  void updateCliente(ClienteDTO cliente) {
    final index = clientes.indexWhere((c) => c.id == cliente.id);
    if (index != -1) {
      setState(() {
        clientes[index] = cliente;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clientes Cadastrados',
              style: TextStyle(fontSize: 18),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];
                return Card(
                  child: ListTile(
                    title: Text(cliente.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CPF: ${cliente.cpf}'),
                        Text('CEP: ${cliente.cep}'),
                        Text('Endereço: ${cliente.endereco}'),
                        Text('Número da Casa: ${cliente.numeroCasa}'),
                        Text('Modelo: ${cliente.modelo}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmar exclusão'),
                              content: Text(
                                  'Tem certeza de que deseja excluir este cliente?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Excluir'),
                                  onPressed: () {
                                    _deleteCliente(cliente.id);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetalhesCliente(cliente: cliente),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
