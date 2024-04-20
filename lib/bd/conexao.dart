import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static const _dbname = "fenixdb";
  static const _sqlscript =
      'CREATE TABLE clientes(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, cpf TEXT,'
      'cep TEXT, endereco TEXT, numerocasa INT, placa TEXT, modelo TEXT)';

  static const table = 'clientes';
  static const columnId = 'id';
  static const columnNome = 'nome';
  static const columnCpf = 'cpf';
  static const columnCep = 'cep';
  static const columnEndereco = 'endereco';
  static const columnNumeroCasa = 'numerocasa';
  static const columnPlaca = 'placa';
  static const columnModelo = 'modelo';

  Conexao._privateConstructor();
  static final Conexao instance = Conexao._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDB();
  }
  static Future<String> getDatabasePath() async {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, _dbname);
  }


  Future<Database> initDB() async {
    return openDatabase(
      join((await getDatabasesPath()), _dbname),
        onCreate: (db, version) {
        return db.execute(_sqlscript);
        },
      version: 1,
    );
  }
}