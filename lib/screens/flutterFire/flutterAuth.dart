import 'package:flutter/material.dart';
import 'package:mynewapp/services/authentication_service.dart';

class FlutterAuth extends StatefulWidget {
  const FlutterAuth({Key? key}) : super(key: key);

  @override
  State<FlutterAuth> createState() => _FlutterAuthState();
}

class _FlutterAuthState extends State<FlutterAuth> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String error = '';

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showSignin = true;

  @override
  void dispose() {
    _mailController.dispose();
    _usernameController.dispose();
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
                  showSignin
                      ? Container()
                      : TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(labelText: 'Username'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'cant be null';
                            } else {
                              return null;
                            }
                          },
                        ),
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
                            var email = _mailController.value.text;
                            var username = _usernameController.value.text;
                            var password = _passwordController.value.text;

                            showSignin
                                ? await AuthenticationService()
                                    .logIn(email, password)
                                : await AuthenticationService()
                                    .register(email, username, password);
                          }
                        },
                        child: Text(showSignin ? 'Login' : 'Register')),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      _mailController.text = '';
      _usernameController.text = '';
      _passwordController.text = '';
      showSignin = !showSignin;
    });
  }
}
