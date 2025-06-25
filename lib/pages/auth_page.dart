import 'package:flutter/material.dart';
import 'package:shop/components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 115, 100, 210),
                  Color.fromARGB(255, 97, 61, 193),
                  Color.fromARGB(255, 78, 20, 140),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Container(
                    //  //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    //  margin: EdgeInsets.only(bottom: 20),
                    //  child: ClipRRect(borderRadius: BorderRadius.circular(50), child: Image.asset('assets/images/shop-logo.png', width: 100,))
                    //),
                    Text(
                      'Shop',
                      style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Sarina',
                        color: Theme.of(context).colorScheme.onPrimary,
                        shadows: [Shadow(color: Colors.black38, blurRadius: 10)],
                      ),
                    ),
                    AuthForm()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
