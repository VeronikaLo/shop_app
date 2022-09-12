import 'package:flutter/material.dart';


class UserProductItem extends StatelessWidget {
  const UserProductItem(this.title, this.imageUrl,{super.key});

  final String title;
  final String imageUrl;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        title: Text(title),
        trailing: SizedBox(
          width: 100,
          child: Row(children: [
            IconButton(onPressed: (){}, icon:  const Icon(Icons.edit), color: Theme.of(context).primaryColor,),
            IconButton(onPressed: (){}, icon: const Icon(Icons.delete), color: Theme.of(context).primaryColor,),
          ]),
        ),
    
      ),
    );
  }
}