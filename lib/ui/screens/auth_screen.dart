// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import 'main_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _passwordVisible = false;
  var _loading = false;
  bool _isLogin = true;

  final Map<String, String> _authData = {
    'name': '',
    'surname': '',
    'username': '',
    'password': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Xatolik'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay!'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _loading = true;
      });
      try {
        if (_isLogin) {
          final loginResponse =
              await Provider.of<AuthProvider>(context, listen: false).login(
            _authData['username']!,
            _authData['password']!,
          );
          if (loginResponse != null) {
            Navigator.of(context).pushReplacementNamed(
              MainScreen.routeName,
            );
          } else {
            _showErrorDialog('Username yoki Parol xato!');
          }
        } else {
          final registerResponse =
              await Provider.of<AuthProvider>(context, listen: false).register(
            _authData['name']!,
            _authData['surname']!,
            _authData['username']!,
            _authData['password']!,
          );
          if (registerResponse != null) {
            // await Provider.of<ProfileProvider>(context, listen: false).getUser();
            await Provider.of<AuthProvider>(context, listen: false).login(
              _authData['username']!,
              _authData['password']!,
            );
            Navigator.of(context).pushReplacementNamed(
              MainScreen.routeName,
            );
          } else {
            _showErrorDialog('Nimadur xato!');
          }
        }
      } on HttpException catch (error) {
        var errorMessage = 'Xatolik sodir bo\'ldi.';
        if (error.message.contains('INVALID_PASSWORD')) {
          errorMessage = 'Parol noto\'g\'ri.';
        }
        _showErrorDialog(errorMessage);
      } catch (e) {
        var errorMessage =
            'Kechirasiz xatolik sodir bo\'ldi. Qaytadan o\'rinib ko\'ring.';
        _showErrorDialog(errorMessage);
      }
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22,
            vertical: MediaQuery.of(context).padding.top + 44,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/auth_image.png',
                  height: 201,
                  width: 201,
                ),
                const SizedBox(height: 18),
                if (!_isLogin)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Isim',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return 'Iltimos, isim kiriting.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['name'] = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Familiya',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (surname) {
                          if (surname == null || surname.isEmpty) {
                            return 'Iltimos, familiya kiriting.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['surname'] = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Iltimos, username kiriting.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['username'] = value!;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Parol',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  obscureText: !_passwordVisible,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Iltimos, parolni kiriting.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                const SizedBox(height: 38),
                _loading
                    ? const CircularProgressIndicator()
                    : InkWell(
                        onTap: () {
                          _submit();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _isLogin ? 'Kirish' : 'Ro\'yxatdan o\'tish',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLogin ? 'Hisobingiz yo\'qmi?' : 'Hisobga kirish',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        !_isLogin ? 'Kirish' : 'Ro\'yxatdan o\'tish',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF775A0B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
