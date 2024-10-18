import 'package:agenda/app_state.dart';
import 'package:agenda/models/contact.dart';
import 'package:agenda/views/add.dart';
import 'package:agenda/views/components/item.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => ContactListState();
}

class ContactListState extends State<ContactList> {
  void delete(Contact? contact) {
    setState(() {
      if (contact != null) {
        AppState.contactController.delete(contact);
      }
    });
  }

  void add(Contact contact) {
    setState(() {
      AppState.contactController.add(contact);
    });
  }

  void update(int idx, Contact contact) {
    setState(() {
      AppState.contactController.update(idx, contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Agenda"),
      ),
      body: FutureBuilder(future: AppState.contactController.list(), builder: (context, items){

        if(items.hasData){
          return ListView.builder(
            itemBuilder: (context, index) {
              return ContactListItem(
                this,
                index,
                items.data![index],
              );
            },
            itemCount: items.data!.length);
        }

        return const Text("Ayo");
      }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navega até a tela de criação de contatos e espera um retorno de um contato
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContact()),
          ).then(
            //Caso um contato seja retornado, o adiciona na agenda
            (val){
              if(val is Contact){
                 add(val);
              }
            }
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
