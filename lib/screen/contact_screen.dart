import 'package:flutter/material.dart';
import 'package:sprout_contact/service/user_service.dart';
import 'package:sprout_contact/widgets/contact_screen/contact_list.dart';
import 'package:sprout_contact/widgets/shared/featurenotready.dart';

class ContactScreen extends StatelessWidget {
  final UserService _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF65d691),
        title: Text('CONTACT'),
        centerTitle: true,
      ),
      body: ContactList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
            context: context,
            child: NotReady(),
          );
        },
        backgroundColor: Color(0xFF65d691),
        child: Icon(Icons.add),
      ),
    );
  }
}
