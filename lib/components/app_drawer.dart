import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';

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
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.authOrHome);
            },
          ),
          Divider(color: Color.fromARGB(255, 222, 226, 230),),
          ListTile(
            iconColor: Color.fromARGB(255, 111, 119, 127),
            textColor: Color.fromARGB(255, 111, 119, 127),
            leading: Icon(Icons.receipt_long_outlined),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.orders);
            },
          ),
          Divider(color: Color.fromARGB(255, 222, 226, 230),),
          ListTile(
            iconColor: Color.fromARGB(255, 111, 119, 127),
            textColor: Color.fromARGB(255, 111, 119, 127),
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.products);
            },
          ),
          Divider(color: Color.fromARGB(255, 222, 226, 230),),
          ListTile(
            iconColor: Color.fromARGB(255, 111, 119, 127),
            textColor: Color.fromARGB(255, 111, 119, 127),
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed(AppRoutes.authOrHome);
            },
          ),
        ],
      ),
    );
  }
}
