import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  const OrderItem( this.order, {super.key});

  final ord.OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$ ${order.amount}'),
          subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(order.dateTime)),
          trailing: const IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: null, ),
        ),
      ],)
    );
  }
}