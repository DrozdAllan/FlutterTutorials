import 'package:flutter/material.dart';
import 'package:mynewapp/services/authentication_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// Standard Form
class FlutterfireAuthForm extends StatelessWidget {
  FlutterfireAuthForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.showSignin,
    required TextEditingController usernameController,
    required TextEditingController mailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _usernameController = usernameController,
        _mailController = mailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final bool showSignin;
  final TextEditingController _usernameController;
  final TextEditingController _mailController;
  final TextEditingController _passwordController;
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
            onTap: () {
              _buttonController.reset();
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) =>
                value!.length < 6 ? "at least 6 characters" : null,
            onTap: () {
              _buttonController.reset();
            },
          ),
          // rounded_loading_button package
          RoundedLoadingButton(
              width: 100,
              height: 30,
              controller: _buttonController,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _buttonController.success();
                  var email = _mailController.value.text;
                  var username = _usernameController.value.text;
                  var password = _passwordController.value.text;

                  showSignin
                      ? await AuthenticationService().logIn(email, password)
                      : await AuthenticationService()
                          .register(email, username, password);
                }
                _buttonController.error();
              },
              child: Text(showSignin ? 'Login' : 'Register'))
        ],
      ),
    );
  }
}
