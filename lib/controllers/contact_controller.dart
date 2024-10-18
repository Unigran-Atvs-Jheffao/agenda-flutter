
import 'package:agenda/daos/contacts/in_memory_dao.dart';
import 'package:agenda/daos/contacts/sqlite_dao.dart';
import 'package:agenda/models/contact.dart';

class ContactController {
  
  SqliteDao dao = SqliteDao(); 

  Future<Contact> getById(int index) async {
    return await dao.getById(index);
  }

  Future<List<Contact>> list() async {
    return await dao.all();
  }

  void delete(Contact contact) async {
    dao.delete(contact);
  }

  void update(int id, Contact contact) {
    dao.update(id, contact);
  }

  void add(Contact contact){
    dao.add(contact);
  }
}
