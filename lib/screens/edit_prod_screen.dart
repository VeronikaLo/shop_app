import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';

import '../provider/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  var _editedProd = Product(
    id: DateTime.now().toString(),
    title: "",
    description: "",
    price: 0.0, 
    imageUrl: '',
  );

  @override
  void initState(){
    _imageUrlFocusNode.addListener(_updateUrl);
    super.initState();
  }

  @override
  void dispose(){
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateUrl);

    super.dispose();
  }

  void _updateUrl(){
      if(!_imageUrlFocusNode.hasFocus){
        setState(() {}); //empty setState, to ensure update of the latest data from TextFormField with user-url
      }
  }

  void _saveForm(){
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _saveForm, 
            icon: const Icon(Icons.save_alt_rounded))
        ], ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Title',),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_priceFocusNode);
            },
            onSaved: (value){
              _editedProd = Product(
                id: _editedProd.id, 
                title: value.toString(), 
                description: _editedProd.description, 
                price: _editedProd.price, 
                imageUrl: _editedProd.imageUrl);
            },
          ),

          TextFormField(
            decoration: const InputDecoration(labelText: 'Price',),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _priceFocusNode,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_descriptionFocusNode);
            },
            onSaved: (value){
              _editedProd = Product(
                id: _editedProd.id, 
                title: _editedProd.title, 
                description: _editedProd.description, 
                price: double.parse(value.toString()), 
                imageUrl: _editedProd.imageUrl);
            },
          ),

          TextFormField(
            decoration: const InputDecoration(labelText: 'Description',),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            focusNode: _descriptionFocusNode,
            onSaved: (value){
              _editedProd = Product(
                id: _editedProd.id, 
                title: _editedProd.title, 
                description: value.toString(), 
                price: _editedProd.price, 
                imageUrl: _editedProd.imageUrl);
            },
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(top: 8, right: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),  
              ),
              child: _imageUrlController.text.isEmpty? const Text('Enter a URL', textAlign: TextAlign.center ,):
                    FittedBox(
                      child: Image.network(
                        _imageUrlController.text, 
                        fit: BoxFit.cover,),)
            ),

            Expanded(
              child: TextFormField(
              decoration: const InputDecoration(labelText: 'Image URL',),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.url,
              controller: _imageUrlController,
              focusNode: _imageUrlFocusNode,
              onEditingComplete: (){setState(() {});},
              onFieldSubmitted: (_){_saveForm();},
              onSaved: (value){
              _editedProd = Product(
                id: _editedProd.id, 
                title: _editedProd.title , 
                description: _editedProd.description, 
                price: _editedProd.price, 
                imageUrl: value.toString());
            },
                      ),
            ),

          ],)
        ],) ),
      ),  
    );
  }
}