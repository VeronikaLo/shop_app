import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart' show Cart;
import '../provider/orders.dart';
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
              OrderButton(cart: cart),
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


//OrderButton
class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.cart.totalAmount <=0 || _isLoading ? null : () async{
        setState(() {
          _isLoading = true;
        });
        //place order
        await Provider.of<Orders>(context, listen: false).addOrder(
          widget.cart.items.values.toList(), 
          widget.cart.totalAmount);

        setState(() {
          _isLoading = false;
        });  
        // clear cart
        widget.cart.clear();

      },
      child: _isLoading
      ? const CircularProgressIndicator()  
      : Text('ODER NOW', style: TextStyle(color: Theme.of(context).primaryColor),),);
  }
}