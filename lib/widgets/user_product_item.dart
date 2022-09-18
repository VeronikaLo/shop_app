import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';


class UserProductItem extends StatelessWidget {
  const UserProductItem(this.id, this.title, this.imageUrl,{super.key});
  final String id;
  final String title;
  final String imageUrl;


  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        title: Text(title),
        trailing: SizedBox(
          width: 100,
          child: Row(children: [
            IconButton(
              onPressed: (){Navigator.of(context).pushNamed('/edit_screen', arguments: id );}, 
              icon:  const Icon(Icons.edit), 
              color: Theme.of(context).primaryColor,),
            IconButton(
              onPressed: () async{
                try{ await Provider.of<Products>(context, listen: false).deleteProduct(id);}
                catch(error){
                  scaffold.showSnackBar(const SnackBar(
                    content: Text('Deleting failed!', textAlign: TextAlign.center,),
                    backgroundColor: Colors.pink,));
                }}, 
              icon: const Icon(Icons.delete), 
              color: Theme.of(context).primaryColor,),
          ]),
        ),
    
      ),
    );
  }
}