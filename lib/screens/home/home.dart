import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 60.0,
            ),
            child: const SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('Logout'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              )
            ),
            TextButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
              onPressed: () => _showSettingsPanel(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              )
            )
          ],
        ),
        body: const BrewList(),
      ),
    );
  }
}
