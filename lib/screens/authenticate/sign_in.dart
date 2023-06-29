import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
 
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  
  // text field state
  String email = ''; 
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Register'),
            onPressed: () => {
              widget.toggleView()
            }
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Email'),
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              }
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Password'),
              validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);
              }
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[400],
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      loading = false;
                      error = 'Could not sign in with those credentials';
                    });
                  }
                  
                  if (kDebugMode) {
                    print('valid');
                  }
                }
              },
              child: const Text(
                'Sign in',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              error,
              style: const TextStyle(
                color: Colors.red, 
                fontSize: 14.0
              ),
            ),
          ]),
        )
      )
    );
  }
}
