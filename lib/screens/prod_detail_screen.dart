import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products_provider.dart';


class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prodId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findById(prodId);
    return Scaffold(
      appBar: AppBar(title:  Text(loadedProduct.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover,),),
            const SizedBox(height: 20,),
            Text(
              '\$ ${loadedProduct.price}', 
              style: const TextStyle(fontSize: 22) ,),
            const SizedBox(height: 25,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                loadedProduct.description, 
                style: const TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
                softWrap: true,),
            )
          ],
        ),
      ),
    );
  }
}