import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  void onNameChanged(String value) {
    setState(() {
      _currentName = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            decoration: textInputDecoration,
            validator: validateName,
            onChanged: onNameChanged,
          ),
          const SizedBox(height: 20.0),
          // dropdown
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentSugars ?? '0',
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
          // button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[400],
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (kDebugMode) {
                  print('valid');
                  print(_currentName);
                  print(_currentSugars);
                  print(_currentStrength);
                }
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
  }
}
