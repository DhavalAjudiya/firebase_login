import 'package:firebase_flutter_app/repo/auth_repo.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();

  final _pass = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _email,
                decoration: InputDecoration(hintText: 'email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '* required';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _pass,
                decoration: InputDecoration(hintText: 'password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '* required';
                  } else {
                    return null;
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AuthRepo.registrationRepo(
                        email: _email.text, pass: _pass.text);
                  }
                },
                child: Text('Registration'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool? status = await AuthRepo.loginRepo(
                        email: _email.text, pass: _pass.text);

                    if (status == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login success!'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login failed!'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  AuthRepo.currentUser();
                },
                child: Text('current user'),
              ),
              ElevatedButton(
                onPressed: () {
                  AuthRepo.logOut();
                },
                child: Text('logout'),
              ),
              ElevatedButton(
                onPressed: () {
                  AuthRepo.deleteuseraccount(
                      context: context, email: _email.text, pass: _pass.text);
                },
                child: Text('delete user'),
              ),
              ElevatedButton(
                onPressed: () {
                  AuthRepo.sendpasswordresetemail(
                      context: context, email: _email.text);
                },
                child: Text('forget pass'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
