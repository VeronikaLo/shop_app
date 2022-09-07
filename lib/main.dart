import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ap/screens/prod_detail_screen.dart';
import 'package:shop_ap/screens/prod_overview_screen.dart';
import './provider/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink ,
          fontFamily: 'Lato',
        ),
        home:  ProductOverviewScreen(),
        routes: {
          '/prod_detail':(context) => const ProductDetailScreen(),
        },
      ),
    );
  }
}



