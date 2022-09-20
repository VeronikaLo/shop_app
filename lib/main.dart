import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ap/provider/orders.dart';
import 'package:shop_ap/screens/authent_screen.dart';
import 'package:shop_ap/screens/cart_screen.dart';
import 'package:shop_ap/screens/edit_prod_screen.dart';
import 'package:shop_ap/screens/orders_screen.dart';
import 'package:shop_ap/screens/prod_detail_screen.dart';
import 'package:shop_ap/screens/prod_overview_screen.dart';
import 'package:shop_ap/screens/user_product_screen.dart';
import './provider/products_provider.dart';
import './provider/cart.dart';
import './provider/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=> Auth()),
        ChangeNotifierProvider( // provider with data for thr products
          create:(context) => Products()),
        ChangeNotifierProvider( // provider for the cart
          create: (context) => Cart()),
        ChangeNotifierProvider(
          create: (context) => Orders(), //provider for order
        ), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink ,
          fontFamily: 'Lato',
        ),
        //home:  const ProductOverviewScreen(),
        routes: {
          //'/':(context) => const ProductOverviewScreen(),
          '/': (context) => const AuthScreen(),
          '/prod_detail':(context) => const ProductDetailScreen(),
          '/cart_screen':(context) => const CartScreen(),
          '/orders_screen':(context) => const OrdersScreen(),
          '/user_products_screen':(context) => const UserProductsScreen(),
          '/edit_screen':(context) => const EditProductScreen(),
        },
      ),
    );
  }
}



