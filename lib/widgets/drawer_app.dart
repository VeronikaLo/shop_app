import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
      AppBar(
        title:const Text('Hello Friend!'),
        automaticallyImplyLeading: false, // to not get a back button
      ),
      const Divider(),
      ListTile(
        leading: const Icon (Icons.shop),
        title:  const Text('Shop'),
        onTap: (){
          Navigator.of(context).pushReplacementNamed('/');
        } ,
      ),

      const Divider(),
      ListTile(
        leading: const Icon (Icons.payments),
        title:  const Text('Orders'),
        onTap: (){
          Navigator.of(context).pushReplacementNamed('/orders_screen');
        } ,
      ),
      const Divider(),

      ListTile(
        leading: const Icon (Icons.edit),
        title:  const Text('Manage Products'),
        onTap: (){
          Navigator.of(context).pushReplacementNamed('/user_products_screen');
        } ,
      ),
      const Divider(),

    ],));
  }
}