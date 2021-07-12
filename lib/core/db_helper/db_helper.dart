import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_smple/core/model/db_model.dart';

class DB {

  // static final DB instance = DB._init();
  //  DB._init();

  String TodoTablo = "tablo";
  String colId = "id";
  String colBaslik = "baslik";
  String colTarih = "tarih";
  String colKonum = "konum";
  String colTamamlandimi = "tamamlandimi";

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, "todo2.db"),
        onCreate: (database, version) async {
          await database.execute(
              "CREATE TABLE $TodoTablo($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colBaslik TEXT, $colKonum TEXT, $colTarih TEXT, $colTamamlandimi INTEGER)");
          print("*****Tablo oluştu");
        }, version: 1);
  }

  Future<bool> insertData(TodoModel todoModel) async {
    final Database db = await initDatabase();
    db.insert("$TodoTablo", todoModel.toMap());
    print("*****Not eklendi");

    return true;
  }

  Future<List<TodoModel>> dataGetir() async {
    final Database db = await initDatabase();
    final List<Map<String, dynamic>> datalar = await db.query("$TodoTablo");
    final result = datalar.map((e) => TodoModel.fromMap(e)).toList();
    return result;
  }
  Future<void> duzenle(TodoModel todoModel,) async{
    final Database db = await initDatabase();
     await db.update("$TodoTablo", todoModel.toMap(),where: "id=?",whereArgs: [todoModel.id]);

  }
  Future<void> sil(int id) async{
    final Database db = await initDatabase();
    await db.delete("$TodoTablo", where: "id=?",whereArgs: [id]);

  }
}
