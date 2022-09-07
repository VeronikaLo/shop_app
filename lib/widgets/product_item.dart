import 'package:flutter/material.dart';
  
class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  
  const ProductItem(this.id, this.title, this.imageUrl, {super.key});
  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTileBar(
          backgroundColor: Colors.black26,
          title: Text(title, textAlign: TextAlign.center,) ,
          leading: IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: (){},),
          trailing:IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: (){},),
        ),
      ),
      child: GestureDetector(
        onTap: (() => Navigator.of(context).pushNamed('/prod_detail', arguments: id)),
        child: Image.network(imageUrl, fit:BoxFit.cover)),
    );
  }
}