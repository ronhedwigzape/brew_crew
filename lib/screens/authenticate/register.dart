import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // text field state
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign up to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Sign in'),
            onPressed: () => {
              widget.toggleView(),
            }
          ),
        ],
      ),
      body: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(children: <Widget>[
            const SizedBox(height: 20.0),
            TextFormField(onChanged: (val) {
              setState(() => email = val);
            }),
            const SizedBox(height: 20.0),
            TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[400],
              ),
              onPressed: () async {
                if (kDebugMode) {
                  print('email: $email');
                  print('password: $password');
                }
              },
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            )
          ]),
        )
      )
    );
  }
}