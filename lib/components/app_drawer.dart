import 'package:flutter/material.dart';

import '../utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Welcome, User!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            automaticallyImplyLeading: false,
          ),
          SizedBox(height: 10,),
          ListTile(
            iconColor: Color.fromARGB(255, 111, 119, 127),
            textColor: Color.fromARGB(255, 111, 119, 127),
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            },
          ),
          Divider(color: Color.fromARGB(255, 222, 226, 230),),
          ListTile(
            iconColor: Color.fromARGB(255, 111, 119, 127),
            textColor: Color.fromARGB(255, 111, 119, 127),
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.orders);
            },
          ),
        ],
      ),
    );
  }
}
