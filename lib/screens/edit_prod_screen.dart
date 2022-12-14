import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/products_provider.dart';

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
    id: '', //here!
    title: "",
    description: "",
    price: 0.0, 
    imageUrl: '',
  );

  var _isInit = true;
  var isLoading = false;
  var _initValues = {
    'title':'',
    'price':'',
    'description':'',
    'imageUrl': '',
  };

  @override
  void initState(){
    _imageUrlFocusNode.addListener(_updateUrl);
    super.initState();
  }

  @override
  void didChangeDependencies(){
    if(_isInit){
      //final String productId = ModalRoute.of(context)!.settings.arguments.toString() ?? '';

    final arg = ModalRoute.of(context)!.settings.arguments;
    if(arg !=null){
      final productId = arg.toString();

     if(productId != null.toString()){ //??? here!
        _editedProd = Provider.of<Products>(context, listen: false).findById(productId);
      _initValues = {
    'title':_editedProd.title,
    'price':_editedProd.price.toString(),
    'description':_editedProd.description,
    'imageUrl': '',
  };
  _imageUrlController.text = _editedProd.imageUrl;
      }
  }
    _isInit = false;
    super.didChangeDependencies();
    }
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
            
        if(
          (!_imageUrlController.text.startsWith('http')&& !_imageUrlController.text.startsWith('https') ) ||
                (!_imageUrlController.text.endsWith('.png') && 
                !_imageUrlController.text.endsWith('.jpeg') && 
                !_imageUrlController.text.endsWith('.jpg'))) {
          return ;
        }
        setState(() {}); //empty setState, to ensure update of the latest data from TextFormField with user-url
      }
  }


  Future<void> _saveForm() async{

    setState(() {
      isLoading = true;
    });
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    }

    _formKey.currentState!.save();
    if(_editedProd.id != '' ){
      Provider.of<Products>(context, listen: false).updateProduct(_editedProd.id, _editedProd);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else{
      try{
        await Provider.of<Products>(context, listen: false).addProduct(_editedProd);
        
      }catch(error){
        await showDialog(
          context: context, 
          builder: (ctx)=>  AlertDialog(
            title: const Text("An Error occured!"),
            content: const Text('Something went wrong'),
            actions: [
              TextButton(
                onPressed: (){Navigator.of(context).pop();} , 
                child: const Text('Ok'))
            ],
          ));
      }
      finally{
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
      
    }
      
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
      body: isLoading? const Center(
        child: CircularProgressIndicator(),
      ) :  Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(children: [

          TextFormField(    // title field
            initialValue: _initValues['title'],
            decoration: const InputDecoration(labelText: 'Title',),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_priceFocusNode);
            },
            validator: (value){
              if(value!.isEmpty){
                return 'Please provide the missing data';
              }
              return null;
            },
            onSaved: (value){
              _editedProd = Product(
                id: _editedProd.id,
                isFavorite: _editedProd.isFavorite, 
                title: value.toString(), 
                description: _editedProd.description, 
                price: _editedProd.price, 
                imageUrl: _editedProd.imageUrl);
            },
          ),

          TextFormField(  // price field
            initialValue: _initValues['price'],
            decoration: const InputDecoration(labelText: 'Price',),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _priceFocusNode,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_descriptionFocusNode);
            },
            validator: (value){
              if(value!.isEmpty){
                return 'Please provide the missing data';
              }
              if(double.tryParse(value) == null){
                return 'Please enter a valid number ';
              }
              if(double.parse(value) <= 0){
                return 'Please enter the number greater than zero';
              }
              return null;
            },
            onSaved: (value){
              _editedProd = Product(
                id: _editedProd.id,
                isFavorite: _editedProd.isFavorite, 
                title: _editedProd.title, 
                description: _editedProd.description, 
                price: double.parse(value.toString()), 
                imageUrl: _editedProd.imageUrl);
            },
          ),

          TextFormField(  // description field
            initialValue: _initValues['description'],
            decoration: const InputDecoration(labelText: 'Description',),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            focusNode: _descriptionFocusNode,
            validator: ((value) {
              if(value!.isEmpty){
                return 'Please enter a decrition of the product';
              }
              if(value.length < 15){
                return 'Should be at least 15 characters long';
              }
              return null;
            }),
            onSaved: (value){
              _editedProd = Product(
                id: _editedProd.id,
                isFavorite: _editedProd.isFavorite, 
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
              child: _imageUrlController.text.isEmpty? 
              const Text('Enter a URL', textAlign: TextAlign.center ,):
                    FittedBox(
                      child: Image.network(
                        _imageUrlController.text, 
                        fit: BoxFit.cover,),)
            ),

            Expanded(
              child: TextFormField(  // imageUrl field
              
              decoration: const InputDecoration(labelText: 'Image URL',),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.url,
              controller: _imageUrlController,
              focusNode: _imageUrlFocusNode,
              onEditingComplete: (){setState(() {});},
              onFieldSubmitted: (_){_saveForm();},
              validator: ((value) {
                if(value!.isEmpty){
                  return 'Please enter an image URL';
                }
                if(!value.startsWith('http')&& !value.startsWith('https') ){
                  return 'Please enter a valid URL'; 
                }
                if (!value.endsWith('.png') && !value.endsWith('.jpeg') && !value.endsWith('.jpg')){
                  return 'Please enter a valid URL image';
                }
                return null;
              }),
              onSaved: (value){
              _editedProd = Product(
                id: _editedProd.id,
                isFavorite: _editedProd.isFavorite, 
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