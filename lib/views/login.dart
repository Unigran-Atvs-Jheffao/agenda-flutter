import 'package:agenda/app_state.dart';
import 'package:agenda/models/user.dart';
import 'package:agenda/utils/secure_storage.dart';
import 'package:agenda/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SecureStorage.hasTokenSet().then((val) {
      if (val) {
        Navigator.pushReplacementNamed(context, "/listagem");
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Login"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(64),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: "Nome"),
                  controller: usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nome não pode ser vazio";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Senha não pode ser vazia";
                    }

                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: FilledButton(
                    onPressed: () => {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          AppState.usersController.add(User(
                              name: usernameController.value.text,
                              password: passwordController.value.text));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Registrado com sucesso")));
                        }
                      })
                    },
                    child: Text("Cadastrar"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: FilledButton(
                    onPressed: () => {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          try {
                            AppState.usersController
                                .getByName(usernameController.value.text)
                                .then(
                                    (usr) => {SecureStorage.setToken(usr.name)});
                            SecureStorage.hasTokenSet().then((val) {
                              if (val) {
                                Navigator.pushReplacementNamed(
                                    context, "/listagem");
                              }
                            });
                          } catch (_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Usuário não existe")));
                          }
                        }
                      })
                    },
                    child: Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
