import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer_app.dart';
import '../provider/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders'),),
      drawer: const DrawerApp(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i)=>   OrderItem(orderData.orders[i]),),
    );
  }
}