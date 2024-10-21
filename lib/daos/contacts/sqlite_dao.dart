
import 'package:agenda/daos/dao.dart';
import 'package:agenda/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDao extends Dao<int, Contact>{

  late Future<Database> database = init();
  SqliteDao();

  Future<Database> init() async {
     String path = join(await getDatabasesPath(), "contacts.db");
     return openDatabase(path, onCreate: (db,ver) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS contacts(id integer primary key autoincrement, name varchar(64), email varchar(128), phone_number varchar(16))"
        );
     }, version: 1);
  }
  

  @override
  void add(Contact toAdd) async {
    final db = await database;
    db.insert('contacts', toAdd.toMap());
  }

  @override
  Future<List<Contact>> all() async{
    final db = await database;
    List<Map<String, dynamic>> data = await db.query("contacts");
    return List.generate(data.length, (index) => Contact.fromMap(data[index]),);
  }

  @override
  void delete(Contact toRemove) async {
    final db = await database;
    await db.delete('contacts', where: "id = ?", whereArgs: [toRemove.id]);
  }

  @override
  Future<Contact> getById(int id) async {
    final db = await database;
    return Contact.fromMap((await db.query("contacts", where: "id = ?", whereArgs: [id])).first);
  }

  @override
  void update(int id, Contact toUpdate) async{
     final db = await database;
     await db.rawUpdate("update contacts set name=?, email=?, phone_number=? where id = ?", [toUpdate.name,toUpdate.email, toUpdate.phoneNumber, toUpdate.id]);
  }

}