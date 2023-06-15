import 'package:flutter/material.dart';
import 'dart:io';
import '../../picker/user_profile.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.submitFun, required this.isLoading});
  final bool isLoading;
  final void Function(
      String email,
      String password,
      String username,
      String userPhone,
      bool isLogin,
      BuildContext context,
      File image) submitFun;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPhone = '';
  String _userName = '';
  String _userPassword = '';
  bool _isLogin = true;
  File _userImageFile = File('');

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFun(_userEmail.trim(), _userPassword.trim(), _userPhone,
          _userName.trim(), _isLogin, context, _userImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    UserImagePicker(
                      imagePickFn: _pickedImage,
                    ),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined)),
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('userPhone'),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      validator: (value) {
                        String phoneNumber;

                        if (value!.isEmpty) {
                          return 'Phone number is required';
                        }
                        phoneNumber = value.replaceAll(RegExp(r'\D'), '');
                        if (phoneNumber.length < 10) {
                          return 'Invalid phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPhone = value!;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'User Name',
                          prefixIcon: Icon(Icons.person_outlined)),
                      onSaved: (newValue) {
                        _userName = newValue!;
                      },
                    ),
                  TextFormField(
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Please enter at least 7 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'PassWord',
                          prefixIcon: Icon(Icons.lock_outlined)),
                      obscureText: true,
                      onSaved: (newValue) {
                        _userPassword = newValue!;
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'Signup'),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create New Account'
                              : 'I already have an account'),
                        ),
                      ],
                    )
                ],
              )),
        )),
      ),
    );
  }
}
