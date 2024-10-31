import 'package:agenda/daos/dao.dart';
import 'package:agenda/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDao extends Dao<int, User>{

  late Future<Database> database = init();


  Future<Database> init() async {
     String path = join(await getDatabasesPath(), "users.db");
     return openDatabase(path, onCreate: (db,ver) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS users(id integer primary key autoincrement, name varchar(64), password varchar(32))"
        );
     }, version: 1);
  }
  
  @override
  void add(User toAdd) async {
    final db = await database;
    db.insert('users', toAdd.toMap());
  }

  @override
  Future<List<User>> all() async {
    final db = await database;
    List<Map<String, dynamic>> data = await db.query("users");
    return List.generate(data.length, (index) => User.fromMap(data[index]),);
  }

  @override
  void delete(User toRemove) async {
    final db = await database;
    await db.delete('users', where: "id = ?", whereArgs: [toRemove.id]);
  }

  @override
  Future<User> getById(int id) async {
    final db = await database;
    return User.fromMap((await db.query("users", where: "id = ?", whereArgs: [id])).first);
  }

  @override
  Future<User> getByName(String name) async {
    final db = await database;
    return User.fromMap((await db.query("users", where: "name = ?", whereArgs: [name])).first);
  }

  @override
  void update(int id, User toUpdate) async {
    final db = await database;
    await db.rawUpdate("update user set name=?, password=? where id = ?", [toUpdate.name,toUpdate.password, id]);
  
  }
}