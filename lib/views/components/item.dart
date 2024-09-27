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
                            //Cria uma confirmação de remoção
                            var future = showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: const Text(
                                    "Deseja realmente remover este contato ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: const Text("Não")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: const Text("Sim"))
                                ],
                              ),
                            );
                            //Espera até uma ação ser retornada da confirmação, e caso o valor seja sim
                            //deleta o contato, ou manda nulo, que fara com que o nada seja deletado
                            future.then(
                              (value) =>
                                  widget.parent.delete(value ? contact : null),
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
                            //Abre a mesma tela de criar contato com o elemento do contato definido
                            //fazendo com que a tela funcione como uma tela de edição de contato
                            //Mesma idea da tela de listagem, é esperado que o resultado retorne um contato
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddContact(contact: widget.contact),
                              ),
                            ).then(
                              //E se retornar, é realizada uma atualizaçãodo contato fazendo com que os componentes rerenderizem
                              (value) {
                                if (value is Contact) {
                                  widget.parent.update(widget.index, value);
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
