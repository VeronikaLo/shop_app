import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;
import './cart.dart';


class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem( {
    required this.id, 
    required this.amount,
    required this.products,
    required this.dateTime});
}



class Orders with ChangeNotifier{

  List<OrderItem> _orders = [];

  List<OrderItem> get orders{
    return [..._orders];
  }

 // place a new order
  Future<void > addOrder(List<CartItem> cartProducts, double total) async{
    
    final url = Uri.parse('https://shop-1-learn-default-rtdb.europe-west1.firebasedatabase.app/orders.json'); 
    final timeStamp = DateTime.now();
    final response = await http.post(url, body: jsonEncode({
      'amount': total,
      'dateTime': timeStamp.toIso8601String(), //special formate to work with Date
      'products': cartProducts.map((cp) => {
        'id': cp.id,
        'title': cp.title,
        'quantity': cp.quantity,
        'price': cp.price,

      }).toList(),
    }));

    _orders.insert(
      0,
      OrderItem(
        id: jsonDecode(response.body)['name'], 
        amount: total, 
        products: cartProducts, 
        dateTime: timeStamp)
    );
    notifyListeners();
  }

}  


