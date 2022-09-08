import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ap/screens/prod_detail_screen.dart';
import 'package:shop_ap/screens/prod_overview_screen.dart';
import './provider/products_provider.dart';
import './provider/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( // provider with data for thr products
          create:(context) => Products()),
        ChangeNotifierProvider( // provider for the cart
          create: (context) => Cart())  
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink ,
          fontFamily: 'Lato',
        ),
        home:  const ProductOverviewScreen(),
        routes: {
          '/prod_detail':(context) => const ProductDetailScreen(),
        },
      ),
    );
  }
}



