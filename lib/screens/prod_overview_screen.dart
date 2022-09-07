import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';


enum FilterOptions{
  Favorites,
  All
}


class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({super.key});
    
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'), centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: ( FilterOptions selectedValue){
              if( selectedValue == FilterOptions.Favorites ){
                //
              } else{
                //
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_)=>[
              const PopupMenuItem(value: FilterOptions.Favorites, child: Text('Only Favorites'),),
              const PopupMenuItem(value: FilterOptions.All, child: Text('Show All'),)
            ])
        ],),
      body: const ProductsGrid(),
    );
  }
}



