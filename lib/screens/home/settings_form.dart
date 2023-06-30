import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FireUser?>(context);

    return FutureBuilder<UserData>(
      future: DatabaseService(uid: user?.uid).userData.first,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          UserData? userData = snapshot.data;

          _currentName ??= userData?.name;
          _currentSugars ??= userData?.sugars;
          _currentStrength ??= userData?.strength;
          
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                const SizedBox(height: 20.0),
                // dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData?.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentSugars = value;
                    });
                  }, 
                ),
                // slider
                Slider(
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  label: _currentStrength?.toString() ?? '100',
                  activeColor: Colors.brown[_currentStrength ?? userData!.strength!],
                  inactiveColor: Colors.brown[_currentStrength ?? userData!.strength!],
                  value: (_currentStrength ?? userData?.strength)!.toDouble(), // .toDouble() converts int to double
                  onChanged: (val) {
                    if (kDebugMode) {
                      print('Slider value: $val');
                    }
                    setState(() {
                      _currentStrength = val.round();
                    });
                  },
                ),
                // button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user?.uid).updateUserData(
                        _currentSugars ?? userData!.sugars!,
                        _currentName ?? userData!.name!,
                        _currentStrength ?? userData!.strength!,
                      );
                      Navigator.pop(context);
                    }
                    if (kDebugMode) {
                      print('valid');
                      print(_currentName);
                      print(_currentSugars);
                      print(_currentStrength);
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
