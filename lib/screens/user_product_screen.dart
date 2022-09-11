import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer_app.dart';
import '../widgets/user_product_item.dart';
import '../provider/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'), 
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){Navigator.of(context).pushNamed('/edit_screen');}, 
            icon: const Icon(Icons.add))
        ]),
      drawer: const DrawerApp(),  
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsData.items.length ,
          itemBuilder: (ctx, i)=> UserProductItem(
            productsData.items[i].title, 
            productsData.items[i].imageUrl)), ),
    );
  }
}