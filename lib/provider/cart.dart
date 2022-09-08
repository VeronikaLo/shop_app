import 'package:flutter/foundation.dart';


// class for a CartItem
class CartItem{
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id, 
    required this.title, 
    required this.quantity, 
    required this.price});
}


class Cart with ChangeNotifier{

  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items{
    return {..._items};
  }

  int get itemCount{  // a getter for showing how many items in a cart are
    return _items.length;
  }


  void addItem(String productId, String title, double price){

    //firstly check, if we alredy have the Item in a cart
    if(_items.containsKey(productId)){

      // if yes : change  only quantity
      _items.update(
        productId, 
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1 ,
          price: existingCartItem.price,

        ));
    }else{

      //if no : add a new entry Item
      _items. putIfAbsent(
        productId, 
        () => CartItem(
          id: DateTime.now().toString(), 
          title: title, 
          quantity: 1, 
          price: price),);
    }
    notifyListeners();
  }

}