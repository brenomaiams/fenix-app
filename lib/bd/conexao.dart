import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:telaoficina/pages/cadastroClientes.dart';

class Conexao {
  static const _dbname = "fenix.db";
  static const _sqlScript =
      'CREATE TABLE clientes(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, cpf TEXT, cep TEXT, endereco TEXT, numeroCasa TEXT,  modelo TEXT)';

  static const table = 'clientes';
  static const columnId = 'id';
  static const columnNome = 'nome';
  static const columnCpf = 'cpf';
  static const columnCep = 'cep';
  static const columnEndereco = 'endereco';
  static const columnNumeroCasa = 'numeroCasa';
  static const columnModelo = 'modelo';

  Conexao._privateConstructor();
  static final Conexao instance = Conexao._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future<void> init() async {
    _database = await initDB();
  }

  static Future<String> getDatabasePath() async {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, _dbname);
  }

  Future<Database> initDB() async {
    print('Iniciando o banco de dados...');
    return openDatabase(
      join(await getDatabasesPath(), _dbname),
      onCreate: (db, version) async {
        await db.execute(_sqlScript);
        print('Banco de dados criado.');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE clientes ADD COLUMN placaCarro TEXT');
        }
      },
      version: 3,
    );
  }

  Future<void> deleteAllClientes() async {
    final db = await database;
    await db.delete(table);
  }

  Future<List<ClienteDTO>> getAllClientes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return ClienteDTO.fromMap(maps[i]);
    });
  }

  Future<void> deleteCliente(int? id) async {
    await _database?.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateCliente(ClienteDTO cliente) async {
    final db = await database;
    await db.update(
      table,
      cliente.toMap(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<void> updateClienteEdit(ClienteDTO cliente) async {
    final dbClient = await database;
    await dbClient.update(table, cliente.toMap(),
        where: 'id = ?', whereArgs: [cliente.id]);
  }

  
}
