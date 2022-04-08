import 'package:flutter/material.dart';
import 'package:projetchatapp/models/user.dart';
import 'package:projetchatapp/screens/home/user_list.dart';
import 'package:projetchatapp/services/authentication.dart';
import 'package:projetchatapp/services/database.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) throw Exception("user not found");
    final database = DatabaseService(user.uid);
    return StreamProvider<List<AppUserData>>.value(
      initialData: [],
      value: database.users,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('ChatApp'),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(''),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: const UserList(),
      ),
    );
  }
}
