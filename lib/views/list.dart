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
        state.contactController.delete(contact);
      }
    });
  }

  void add(Contact contact) {
    setState(() {
      state.contactController.add(contact);
    });
  }

  void update(int idx, Contact contact) {
    setState(() {
      state.contactController.update(idx, contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Agenda"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ContactListItem(
            this,
            index,
            state.contactController.getByIndex(index),
          );
        },
        itemCount: state.contactController.list().length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContact()),
          ).then(
            (val) => {
              if (val is Contact)
                {
                  setState(() {
                    add(val);
                  }),
                },
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
