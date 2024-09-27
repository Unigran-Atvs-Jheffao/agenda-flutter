import 'package:agenda/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddContact extends StatefulWidget {
  final int? idx;
  final Contact? contact;

  const AddContact({super.key, this.idx, this.contact});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  MaskTextInputFormatter phoneNumberFormatter = MaskTextInputFormatter(
      mask: "(##)#####-####", filter: {"#": RegExp(r'[0-9]')});

  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      nameController = TextEditingController(text: widget.contact!.name);
      phoneNumberController =
          TextEditingController(text: widget.contact!.phoneNumber);
      emailController = TextEditingController(text: widget.contact!.email);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: widget.contact != null
            ? const Text("Editar Contato")
            : const Text("Criar Contato"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Nome"),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "(XX)XXXXX-XXXX"),
                controller: phoneNumberController,
                inputFormatters: [phoneNumberFormatter],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um numero de telefone';
                  }
                  if (phoneNumberFormatter.unmaskText(value).length != 11) {
                    return "Numero de telefone invalido";
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Email"),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um email';
                  }
                  if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return null;
                  }
                  return 'Email invalido';
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Contact contact = Contact(
                          name: nameController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text);
                      if (widget.contact != null) {
                        Navigator.pop(context, {widget.idx: contact});
                      } else {
                        Navigator.pop(context, contact);
                      }
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Salvar"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
