import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart' show Cart;
import '../widgets/cart_item.dart' ;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title:  const Text('Your Cart')),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding:const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text('Total', style: TextStyle(fontSize: 22),),
              const Spacer(),
              const SizedBox(width: 10,),
              Chip(
                label: Text('\$ ${cart.totalAmount}', style: const TextStyle(color: Colors.white),),
                backgroundColor: Theme.of(context).primaryColor ,
              ),
              TextButton(
                onPressed: null,
                child:   Text('ODER NOW', style: TextStyle(color: Theme.of(context).primaryColor),),),
            ]) , ),
        ),
        const SizedBox( height: 15,),
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => CartItem(
              cart.items.values.toList()[i].id,
              cart.items.keys.toList()[i],  //for the productId
              cart.items.values.toList()[i].title, 
              cart.items.values.toList()[i].price, 
              cart.items. values.toList()[i].quantity) ,
            )),
      ]),
    );
  }
}