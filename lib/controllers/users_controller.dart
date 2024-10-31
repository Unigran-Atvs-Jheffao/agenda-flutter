
import 'package:agenda/daos/users/user_dao.dart';
import 'package:agenda/models/user.dart';

class UsersController {
  
  UserDao _dao = UserDao();

  Future<User> getById(int index) async {
    return await _dao.getById(index);
  }

  Future<User> getByName(String name) async {
    return await _dao.getByName(name);
  }

  Future<List<User>> list() async {
    return await _dao.all();
  }

  void delete(User user) async {
    _dao.delete(user);
  }

  void update(int id, User user) {
    _dao.update(id, user);
  }

  void add(User user){
    _dao.add(user);
  }
}
