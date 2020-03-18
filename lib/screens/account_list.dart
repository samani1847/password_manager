import 'dart:async';
import 'package:flutter/material.dart';
import 'package:password_manager/screens/account_detail.dart';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class AccountList extends StatefulWidget {

  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Account> accountList;
  int count = 0;
  
  @override
  Widget build(BuildContext context) {

    if (accountList == null) {
      accountList = List<Account>();
      updateListView();
    }
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Manager'),
      ),

      body: getPasswordListView(context, count),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
         navigateToAccountDetail(Account('', '', ''), 'Add Account');
        },

        tooltip: 'Add Password',
        child: Icon(Icons.add),
      ),
    );
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
            title: Text(this.accountList[position].appname, style: titleStyle,),
            subtitle: Text('Dummy Date'),
            trailing: Icon(Icons.delete, color: Colors.red),
            onTap: () {
              navigateToAccountDetail(this.accountList[position], 'Edit Account');
              debugPrint("list title tapped");
            },
          ),
        );
      },
    ); 
  }

  void navigateToAccountDetail(Account account, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AccountDetail(account, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Account>> accountListFuture = databaseHelper.getAccountList();
      accountListFuture.then((accountList) {
        setState(() {
          this.accountList = accountList;
          this.count = accountList.length;
        });
      });
    });
  }
}


