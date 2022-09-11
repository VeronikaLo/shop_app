import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../provider/cart.dart';



  
class ProductItem extends StatelessWidget {
  const ProductItem({super.key});


  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(context,);
    final cart = Provider.of<Cart>(context, listen: false);  

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
            onPressed: (){
              product.toogleFavoriteStatus();},),
          trailing:IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: (){
              cart.addItem(product.id, product.title, product.price);
              //Snackbar Messenger:
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner(); //add extra time
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                content: const Text('Added item to cart'),
                backgroundColor: Theme.of(context).primaryColor,
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  textColor: Colors.black,
                  label: 'UNDO',
                  onPressed: (() {
                    cart.undo(product.id); //undo function
                  }),) ,),);
            },),
        ),
      ),
      child: GestureDetector(
        onTap: (() => Navigator.of(context).pushNamed('/prod_detail', arguments: product.id)),
        child: Image.network(product.imageUrl, fit:BoxFit.cover)),
    );
  }
}