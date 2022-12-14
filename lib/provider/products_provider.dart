import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;
import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {

late List<Product> _items = [
  /*
  Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    */
];



List<Product> get items{
  return [..._items];
}

List<Product> get favoritesItems{
  return _items.where((prodItem) => prodItem.isFavorite).toList();
}


// method to find product by id
Product findById(String id){
  return _items.firstWhere((prod)=> prod.id == id);
}

//  function add a new product
Future<void> addProduct(Product product) async{
  //1. http request:
  final url = Uri.parse('https://shop-1-learn-default-rtdb.europe-west1.firebasedatabase.app/products.json');
  try{
    final response = await http.post(url, body: jsonEncode({
    'title': product.title,
    'description': product.description,
    'imageUrl': product.imageUrl,
    'price': product.price,
    'isFavorite': product.isFavorite, 
  }) );
  
  final newProduct = Product(
    id: jsonDecode(response.body)['name'], 
    title: product.title, 
    description: product.description, 
    price: product.price, 
    imageUrl: product.imageUrl);

  _items.add(newProduct);
  // _items.insert(0, newProduct)  if we want to put the item at start of the list
  notifyListeners();
  } catch(error){
    debugPrint(error.toString());
    rethrow ;
  }
}

// function update a product (if editing)
  Future<void> updateProduct(String id, Product newProduct ) async{

    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if(prodIndex >= 0){
      final url = Uri.parse('https://shop-1-learn-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
      await http.patch(url, body: jsonEncode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
      }));

      _items[prodIndex] = newProduct;
      notifyListeners();
    }else{
      print('...');
    }
  }

  //function delete a product
  Future<void> deleteProduct(String id) async{

    final url = Uri.parse('https://shop-1-learn-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
    final existingProdIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProd = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();

    final response = await http.delete(url);
      if(response.statusCode >= 400){
        _items.insert(existingProdIndex, existingProd); //insert the Prod again in the list if deleting request fails 
        notifyListeners();
        throw HttpException('Could not delete the product');
      }
    existingProd = null;
     
  }

// function for fetching data from server
Future<void> fetchData()async{

final url = Uri.parse('https://shop-1-learn-default-rtdb.europe-west1.firebasedatabase.app/products.json');
  try{
    final response = await http.get(url);
    //print(jsonDecode(response.body));
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>?;
    if(extractedData == null){
    return;}
    final List<Product> loadedProds = [];
    extractedData.forEach((prodId, prodData){
        loadedProds.add( Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        )
      
        );
    }
    );
    _items = loadedProds;
    notifyListeners();
  }catch(error){
    rethrow;
  }

}

}

