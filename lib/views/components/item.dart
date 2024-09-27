import 'package:agenda/models/contact.dart';
import 'package:agenda/views/add.dart';
import 'package:agenda/views/list.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatefulWidget {
  final ContactListState parent;
  final int index;
  final Contact contact;

  const ContactListItem(this.parent, this.index, this.contact, {super.key});

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    Contact contact = widget.contact;

    return Wrap(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(contact.name),
                    Icon(isOpen
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_left)
                  ],
                ),
              ],
            ),
          ),
        ),
        isOpen
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contact.phoneNumber),
                        Text(contact.email),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            var future = showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                    "Deseja realmente remover este contato ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, "Não");
                                      },
                                      child: const Text("Não")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, "Sim");
                                      },
                                      child: const Text("Sim"))
                                ],
                              ),
                            );
                            future.then(
                              (value) => widget.parent
                                  .delete(value == "Sim" ? contact : null),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.delete_outline),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddContact(
                                    idx: widget.index, contact: widget.contact),
                              ),
                            ).then(
                              (value) {
                                if (value is Map) {
                                  widget.parent.update(
                                      value.keys.first, value.values.first);
                                }
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.edit),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
