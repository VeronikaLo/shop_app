import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer_app.dart';
import '../provider/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  @override
  void initState() {
    // with listen:false the code will also work without Future.delayed hack!
    Future.delayed(Duration.zero).then((_) async{
      setState(() {
        _isLoading = true;
      }); 
      await Provider.of<Orders>(context, listen: false).fetchOrderData();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders'),),
      drawer: const DrawerApp(),
      body: _isLoading
      ? const Center(child: CircularProgressIndicator()) 
      : ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i)=>   OrderItem(orderData.orders[i]),),
    );
  }
}