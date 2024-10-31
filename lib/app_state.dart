import 'package:agenda/controllers/contact_controller.dart';
import 'package:agenda/controllers/users_controller.dart';

//Essa classe apenas gerencia o estado da aplicação enquando executando

class AppState{
  static ContactController contactController = ContactController();
  static UsersController usersController = UsersController();
}