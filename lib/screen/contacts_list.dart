import 'package:bankbyte/models/contact.dart';
import 'package:bankbyte/screen/contacts_form.dart';
import 'package:flutter/material.dart';
import 'package:bankbyte/database/app_database.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacs'),
      ),
      body: FutureBuilder(
        future: findAll(),
        builder: (context, snapshot) {
          final List<Contact> contacts = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) {
              final Contact contact = contacts[index];
              return _ContactItem(contact);
            },
            itemCount: contacts.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactsForm(),
                ),
              )
              .then((newContact) => debugPrint(newContact.toString()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'Alex',
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          '1000',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
