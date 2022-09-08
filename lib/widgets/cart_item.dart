import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {

  final String id;
  final String title;
  final double price;
  final int quantity;

  const CartItem( this.id,  this.title,  this.price,  this.quantity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(child: Text('\$ $price' ,)),),),
          title: Text(title),
          subtitle: Text('Total: \$ ${(price * quantity)}'),
          trailing: Text('$quantity x'),
        ),),
    );
  }
}