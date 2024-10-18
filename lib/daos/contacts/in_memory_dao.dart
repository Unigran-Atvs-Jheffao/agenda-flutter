import 'package:agenda/daos/Dao.dart';
import 'package:agenda/models/contact.dart';

class InMemoryDao extends Dao<int, Contact>{

  final List<Contact> _contacts = [];

  @override
  void add(Contact toAdd) {
    toAdd.id = _contacts.length - 1;
    _contacts.add(toAdd);
  }


  @override
  void delete(Contact toRemove) {
    _contacts.remove(toRemove);
  }

  @override
  void update(int id, Contact toUpdate) {
    toUpdate.id = id;
    _contacts[id] = toUpdate;
  }
  
  @override
  Future<List<Contact>> all() {
    return Future.value(_contacts);
  }
  
  @override
  Future<Contact> getById(int id) {
    return Future.value(_contacts[id]);
  }
}