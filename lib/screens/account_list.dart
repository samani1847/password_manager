import 'package:flutter/material.dart';

class AccountList extends StatefulWidget {
  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  
  int count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Manager'),
      ),

      body: getPasswordListView(context, count),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('pressed');
        },

        tooltip: 'Add Password',
        child: Icon(Icons.add),
      ),
    );
  }
}

ListView getPasswordListView(context, count) {
  
  TextStyle titleStyle = Theme.of(context).textTheme.subhead;

  return ListView.builder(
    itemCount: count,
    itemBuilder: (BuildContext context, int position) {
      return Card(
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.keyboard_arrow_right),
          ),
          title: Text('Dummy Title', style: titleStyle,),
          subtitle: Text('Dummy Date'),
          trailing: Icon(Icons.delete, color: Colors.red),
          onTap: () {
            debugPrint("list title tapped");
          },
        ),
      );
    },
  );
  
}