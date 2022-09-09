import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  const OrderItem( this.order, {super.key});

  final ord.OrderItem order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {

  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$ ${widget.order.amount}'),
          subtitle: Text(DateFormat('dd/ MM/ yyyy   hh:mm').format(widget.order.dateTime)),
          trailing:  IconButton(
            icon:  Icon(_expanded? Icons.expand_less_rounded: Icons.expand_more_rounded),
            onPressed: (){
              setState(() {
                _expanded = !_expanded;
              });
            },
            ),
        ),
        if(_expanded) Container(
          padding: const EdgeInsets.all(15),
          height: min(widget.order.products.length * 30.0 + 20.0, 250),
          child: ListView(children: widget.order.products.map((prod) => 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(prod.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Text('${prod.quantity} x \$${prod.price}', style: const TextStyle(fontSize: 18, color: Colors.grey),),
          ],)).toList(),),

        )
      ],) 
    );
  }
}