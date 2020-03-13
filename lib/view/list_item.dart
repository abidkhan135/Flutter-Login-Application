import 'package:flutter/material.dart';
class ListItem extends StatelessWidget {
  final String fname;
  final String lname;
  final IconData icon;
  ListItem(this.fname,this.lname,this.icon);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fname,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(lname),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.edit),onPressed: (){},color: Theme.of(context).primaryColor,),
            IconButton(icon: Icon(Icons.delete),onPressed: (){},color: Theme.of(context).errorColor,),
          ],
        ),
      ),
    );
  }
}
