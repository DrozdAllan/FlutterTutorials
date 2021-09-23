import 'package:flutter/material.dart';
import 'package:mynewapp/services/firebase_auth.dart';

class FlutterFire extends StatefulWidget {
  const FlutterFire({Key? key}) : super(key: key);

  static const routeName = '/flutterFire';

  @override
  State<FlutterFire> createState() => _FlutterFireState();
}

class _FlutterFireState extends State<FlutterFire> {
  final AuthenticationService _auth = AuthenticationService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showSignin = true;

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What is Flutter Fire ?'),
        actions: [
          TextButton.icon(
            onPressed: () => toggleView(),
            icon: Icon(Icons.person),
            label: Text(
              showSignin ? 'Register' : 'Sign In',
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Text(
                'FlutterFire is the implementation of Firebase components in flutter app, here we will use the basic of Auth and Firestore'),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _mailController,
                      decoration: InputDecoration(labelText: 'Mail'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'cant be null';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) =>
                          value!.length < 6 ? "at least 6 characters" : null,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _register();
                            }
                          },
                          child: Text(showSignin ? 'Login' : 'Register')),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      _mailController.text = '';
      _passwordController.text = '';
      showSignin = !showSignin;
    });
  }

  Future<void> _register() async {
    setState(() => loading = true);
    var email = _mailController.value.text;
    var password = _passwordController.value.text;
    // var name = nameController.value.text;

    dynamic result = showSignin
        ? await _auth.signInWithEmailAndPassword(email, password)
        : await _auth.registerWithEmailAndPassword('surnom', email, password);

    if (result == null) {
      setState(() {
        loading = false;
        error = 'Please supply a valid email';
      });
    }
  }
}
