import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void dispose(){
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true, ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(child: ListView(children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Title',),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_priceFocusNode);
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
          ),

          TextFormField(
            decoration: const InputDecoration(labelText: 'Description',),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            focusNode: _descriptionFocusNode,
          ),
        ],) ),
      ),  
    );
  }
}