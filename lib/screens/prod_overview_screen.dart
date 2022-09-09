import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/drawer_app.dart';

import 'package:provider/provider.dart';
import '../provider/cart.dart';


enum FilterOptions{
  Favorites,
  All
}


class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {

  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'), centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: ( FilterOptions selectedValue){
              setState(() {
                if( selectedValue == FilterOptions.Favorites ){
                _showOnlyFavorites = true;
              } else{
                _showOnlyFavorites = false;
              }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_)=>[
              const PopupMenuItem(value: FilterOptions.Favorites, child: Text('Only Favorites'),),
              const PopupMenuItem(value: FilterOptions.All, child: Text('Show All'),)
            ]),
            Consumer<Cart>(
              builder: (ctx, cartData, _) =>
              Badge( 
              value: cartData.itemCount.toString(), 
              child:  IconButton(
                icon: const Icon(Icons.shopping_cart , color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).pushNamed('/cart_screen');
                },) , 
              ) ,), 
              
        ],),
      drawer: const DrawerApp(),
      body:   ProductsGrid(_showOnlyFavorites),
    );
  }
}



