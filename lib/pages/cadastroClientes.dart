import 'package:flutter/material.dart';
import 'package:telaoficina/bd/conexao.dart';
import 'package:telaoficina/cores/minhasCores.dart';

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
      numeroCasa: numeroCasaController.text,
      modelo: modeloController.text,
    );
    
    final db = Conexao.instance.database;
    final dbClient = await db;
    await dbClient.insert(Conexao.table, clienteDTO.toMap());

    print("Cliente salvo com sucesso");

    // Atualizar a lista de clientes na aba "Início"
    Inicio? inicio = context.findAncestorWidgetOfExactType<Inicio>();
    if (inicio != null) {
      await inicio.updateClientesList();
}

    setState(() {
      // Resetar os campos após salvar o cliente
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
          backgroundColor: MinhasCores.vermelhoescuro,
          title: Text(
            'Cadastro de Clientes',
            style: TextStyle(
              color: MinhasCores.preto,
              fontSize: 24,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.add),
                child: Text(
                  'Cadastro',
                  style: TextStyle(color: MinhasCores.preto),
                ),
              ),
              Tab(
                icon: Icon(Icons.home),
                child: Text(
                  'Início',
                  style: TextStyle(color: MinhasCores.preto),
                ),
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
                  onPressed: () async{
                    await Conexao.instance.deleteAllClientes();
                    Inicio? inicio = context.findAncestorWidgetOfExactType<Inicio>();
                     if (inicio != null) {
                      await inicio.updateClientesList();
                  }
                },
                child: Text('Apagar todos os clientes'),
            )],
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
    // ignore: unnecessary_null_comparison
    if (db != null) {
      List<ClienteDTO> clientesList = await Conexao.instance.getAllClientes();

      setState(() {
        clientes = clientesList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visualização de Dados',
            style: TextStyle(fontSize: 18),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(clientes[index].nome),
                subtitle: Text(clientes[index].cpf),
              );
            },
          ),
        ],
      ),
    );
  }
}
