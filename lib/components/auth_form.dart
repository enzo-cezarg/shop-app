import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { signUp, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  AuthMode _authMode = AuthMode.login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  AnimationController? _controller;

  bool _isLogin() => _authMode == AuthMode.login;

  bool _isSignup() => _authMode == AuthMode.signUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    if (_isSignup()) {
      _controller?.value = 1.0;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    _passwordController.dispose();
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Something went wrong.'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Close'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.login(_authData['email']!, _authData['password']!);
      } else {
        await auth.signUp(_authData['email']!, _authData['password']!);
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  void _switchAuthMode() {
    if (_isLogin()) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
      _controller?.forward();
    } else {
      _controller?.reverse().then((_) {
        setState(() {
          _authMode = AuthMode.login;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (ctx, child) => Container(
          height: _isLogin() ? 310 : 310 + (_controller!.value * 90), // 90 de espaço para "confirm password"
          width: deviceSize.width * 0.85,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: child,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (inputEmail) {
                  final email = inputEmail ?? '';
                  if (email.trim().isEmpty) {
                    return 'This field is required.';
                  }
                  if (!email.contains('@')) {
                    return 'Invalid email.';
                  }
                  return null;
                },
                onSaved: (email) => _authData['email'] = email ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: _passwordController,
                validator: (inputPassword) {
                  final password = inputPassword ?? '';
                  if (password.trim().isEmpty) {
                    return 'This field is required.';
                  }
                  if (password.length < 5) {
                    return 'Password must be at least 5 characters long.';
                  }
                  return null;
                },
                onSaved: (password) => _authData['password'] = password ?? '',
              ),
              SizeTransition(
                sizeFactor: _controller!,
                axisAlignment: -1.0,
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: _isLogin()
                      ? null
                      : (inputPassword) {
                          final password = inputPassword ?? '';
                          if (password != _passwordController.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                ),
              ),
              SizedBox(height: 20),
              if (_isLoading)
                CircularProgressIndicator(
                  strokeWidth: 3,
                )
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary),
                  child: Text(
                    _authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepPurple.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(_isLogin() ? 'New here? Create an account.' : 'Already have an account? Log in.'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
