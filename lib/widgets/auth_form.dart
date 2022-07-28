import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_pt/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:my_pt/models/error.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'username': '',
    'password': '',
  };

  var _isLoading = false;
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode usernameFocusNode;
  late FocusNode confirmPassFocusNode;

  late bool _passwordHidden;
  late bool _confirmPassHidden;

  @override
  void initState() {
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPassFocusNode = FocusNode();
    usernameFocusNode = FocusNode();
    _passwordHidden = true;
    _confirmPassHidden = true;
    super.initState();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    confirmPassFocusNode.dispose();
    usernameFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).signIn(
          _authData['email'] as String,
          _authData['password'] as String,
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'] as String,
          _authData['username'] as String,
          _authData['password'] as String,
        );
      }
    }
//
    catch (error) {
      String errorText;
      var data = json.decode(error.toString());
      if (error is SocketException) {
        errorText = "Check your internet conncetion and try again.";
      }
      if (data['detail'][0] != null) {
        errorText = data['detail'][0];
      } else {
        errorText = "Couldn't log you in. Try again.";
      }
      print('error: $errorText');
      Error.showErrorDialog(errorText, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          _authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    // )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade100))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                keyboardType: TextInputType.emailAddress,
                                autofocus: true,
                                focusNode: emailFocusNode,
                                controller: _emailController,
                                validator: (value) {
                                  final bool isValid =
                                      EmailValidator.validate(value as String);
                                  if (!isValid) {
                                    return 'Please enter a valid email adress';
                                  } else {
                                    return null;
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(usernameFocusNode);
                                },
                                onSaved: (value) {
                                  _authData['email'] = value as String;
                                },
                              ),
                            ),
                            if (_authMode == AuthMode.signup)
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  enabled: _authMode == AuthMode.signup,
                                  focusNode: usernameFocusNode,
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Invalid username!';
                                    }
                                  },
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocusNode);
                                  },
                                  onSaved: (value) {
                                    _authData['username'] = value as String;
                                  },
                                ),
                              ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _passwordHidden = !_passwordHidden;
                                        });
                                      },
                                      icon: Icon(
                                        _passwordHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Color.fromRGBO(143, 148, 251, .6),
                                      ),
                                    ),
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                                obscureText: _passwordHidden,
                                controller: _passwordController,
                                validator: (value) {
                                  if (_authMode == AuthMode.signup) {
                                    if (value!.isEmpty || value.length < 5) {
                                      return 'Password is too short!';
                                    }
                                  }
                                  if (value!.isEmpty) {
                                    return "Password can't be empty!";
                                  }
                                },
                                focusNode: passwordFocusNode,
                                textInputAction: _authMode == AuthMode.signup
                                    ? TextInputAction.next
                                    : TextInputAction.done,
                                onFieldSubmitted: (_) {
                                  if (_authMode == AuthMode.signup) {
                                    FocusScope.of(context)
                                        .requestFocus(confirmPassFocusNode);
                                  }
                                  _submit();
                                },
                                onSaved: (value) {
                                  _authData['password'] = value as String;
                                },
                              ),
                            ),
                            if (_authMode == AuthMode.signup)
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  enabled: _authMode == AuthMode.signup,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _confirmPassHidden =
                                                !_confirmPassHidden;
                                          });
                                        },
                                        icon: Icon(
                                          _passwordHidden
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color.fromRGBO(
                                              143, 148, 251, .6),
                                        ),
                                      ),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  focusNode: confirmPassFocusNode,
                                  onFieldSubmitted: (_) {
                                    _submit();
                                  },
                                  textInputAction: TextInputAction.done,
                                  obscureText: _confirmPassHidden,
                                  validator: _authMode == AuthMode.signup
                                      ? (value) {
                                          if (value !=
                                              _passwordController.text) {
                                            return 'Passwords do not match!';
                                          }
                                        }
                                      : null,
                                ),
                              ),
                          ],
                          // ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    if (_isLoading)
                      // FadeAnimation(
                      // 2,
                      const CircularProgressIndicator(
                        color: Color.fromRGBO(143, 148, 251, .6),
                      )
                    // )
                    else
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(
                            child: TextButton(
                              child: Text(
                                _authMode == AuthMode.login
                                    ? 'LOGIN'
                                    : 'SIGN UP',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: _submit,
                            ),
                            // ),
                          )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: Text(
                        _authMode == AuthMode.login
                            ? 'Create an account'
                            : 'Have an account? login instead.',
                        style: const TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1)),
                      ),
                      onPressed: _switchAuthMode,
                    )
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
