import 'package:flutter/material.dart';
import 'package:mynewapp/utils/flutterAuthForm.dart';

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
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
                'FlutterFire is the implementation of Firebase components in flutter app, here we will use the basic of Auth and Firestore'),
            Container(
              child: FlutterfireAuthForm(
                  formKey: _formKey,
                  showSignin: showSignin,
                  usernameController: _usernameController,
                  mailController: _mailController,
                  passwordController: _passwordController),
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
      _usernameController.text = '';
      _passwordController.text = '';
      showSignin = !showSignin;
    });
  }
}
