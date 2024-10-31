import 'package:agenda/views/add.dart';
import 'package:agenda/views/list.dart';
import 'package:agenda/views/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Cria a base da aplicação com um tema escuro usando roxo como cor principal, inicializado a tela de listagem
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
            cardColor: Colors.grey.shade900,
            backgroundColor: Colors.white,
            accentColor: Colors.white,
            brightness: Brightness.dark,
            primarySwatch: Colors.purple),
      ),
      initialRoute: "/login",
      routes: {
        "/login": (context) => const Login(),
        "/listagem": (context) => const ContactList(),
        "/contato": (context) => const AddContact()
      }
    );
  }
}
