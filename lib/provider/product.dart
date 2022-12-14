import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;

class Product with ChangeNotifier{

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.price, 
    required this.imageUrl, 
    this.isFavorite = false});


    Future<void> toogleFavoriteStatus()async{ 
      final oldStatus = isFavorite;
      isFavorite= !isFavorite;
      notifyListeners();

      final url = Uri.parse('https://shop-1-learn-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
      try{
        final response = await http.patch(url, body: jsonEncode({
        'isFavorite': isFavorite,
      }));
      if(response.statusCode >= 400){
        isFavorite = oldStatus;
        notifyListeners();
      }
      }catch(error){
        isFavorite = oldStatus;
        notifyListeners();
      } 

    }

}