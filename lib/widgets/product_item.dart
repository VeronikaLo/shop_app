import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';



  
class ProductItem extends StatelessWidget {
  const ProductItem({super.key});


  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(context);

    return GridTile(
      footer: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTileBar(
          backgroundColor: Colors.black26,
          title: Text(product.title, textAlign: TextAlign.center,) ,
          leading: IconButton(
            icon:  Icon( 
              product.isFavorite? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite? Theme.of(context).primaryColor: Colors.white),
            onPressed: (){product.toogleFavoriteStatus();},),
          trailing:IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: (){},),
        ),
      ),
      child: GestureDetector(
        onTap: (() => Navigator.of(context).pushNamed('/prod_detail', arguments: product.id)),
        child: Image.network(product.imageUrl, fit:BoxFit.cover)),
    );
  }
}