
import 'package:agenda/models/contact.dart';

class ContactController {
  
  final List<Contact> _contacts = [];

  Contact getByIndex(int index) {
    if (index < 0 || index >= _contacts.length) {
      throw "Index out of bound for contact list of size ${_contacts.length}";
    }

    return _contacts[index];
  }

  List<Contact> list() {
    return _contacts;
  }

  void delete(Contact contact) {
    _contacts.remove(contact);
  }

  void update(int index, Contact contact) {
    if (index < 0 || index >= _contacts.length) {
      throw "Index out of bound for contact list of size ${_contacts.length}";
    }

    _contacts[index] = contact;
  }

  void add(Contact contact){
    _contacts.add(contact);
  }
}
