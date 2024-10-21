
import 'package:agenda/daos/contacts/in_memory_dao.dart';
import 'package:agenda/daos/contacts/sqlite_dao.dart';
import 'package:agenda/models/contact.dart';

class ContactController {
  
  SqliteDao _dao = SqliteDao(); 

  Future<Contact> getById(int index) async {
    return await _dao.getById(index);
  }

  Future<List<Contact>> list() async {
    return await _dao.all();
  }

  void delete(Contact contact) async {
    _dao.delete(contact);
  }

  void update(int id, Contact contact) {
    _dao.update(id, contact);
  }

  void add(Contact contact){
    _dao.add(contact);
  }
}
