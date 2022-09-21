import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;

class Auth with ChangeNotifier{
  String? _token;
  DateTime? _expiryDate;
  String?  _userId;
  

//sign up function
  Future<void> signUp(String email, String password) async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAj1ZJgRI8T83NHIgrKHNzgqhltbldpTcg');
    final response = await http.post(url, body:jsonEncode({
      'email':email,
      'password': password,
      'returnSecureToken':true,
    }));
    debugPrint (jsonDecode(response.body).toString());
  }


//sign in (login) function
Future<void> login(String email, String password) async{
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAj1ZJgRI8T83NHIgrKHNzgqhltbldpTcg');
    final response = await http.post(url, body:jsonEncode({
      'email':email,
      'password': password,
      'returnSecureToken':true,
    }));
    debugPrint (jsonDecode(response.body).toString());
  }



}