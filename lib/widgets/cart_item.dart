import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartItem extends StatelessWidget {

  final String id;  // cart item id
  final String productId; //product id
  final String title;
  final double price;
  final int quantity;

  const CartItem( this.id,this.productId,  this.title,  this.price,  this.quantity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(
          context: context, 
          builder: (ctx)=>  AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to remove the item from the cart?'),
            actions: [
              TextButton(onPressed: (){Navigator.of(context).pop(true);} , child: const Text('YES') ,),
              TextButton(onPressed: (){Navigator.of(context).pop(false);} , child: const Text('NO') ,)
            ],
          ));
      },
      onDismissed: (direction) => Provider.of<Cart>(context, listen: false).removeItem(productId)  ,
      background: Container(
        color:Colors.red[900],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: const Icon(Icons.delete, color: Colors.white, size: 40,)),
      child: Card(
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
      ),
    );
  }
}