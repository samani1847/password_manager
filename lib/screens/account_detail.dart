import 'package:flutter/material.dart';
import 'dart:async';
import 'package:password_manager/model/account.dart';
import 'package:password_manager/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class AccountDetail extends StatefulWidget {

  final String appBarTitle;
  final Account account;

  AccountDetail(this.account, this.appBarTitle);
 
  @override
  _AccountDetailState createState() => _AccountDetailState(this.account, this.appBarTitle);
}

class _AccountDetailState extends State<AccountDetail> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  Account account;
  String appBarTitle;

  TextEditingController appNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _AccountDetailState(this.account, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    appNameController.text = account.appname;
    usernameController.text = account.username;
    passwordController.text = account.password;
    

    return Scaffold(
      appBar: AppBar(
        title: Text(this.appBarTitle),
      ), 

      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left:10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left:10.0, right: 10.0),
              child: TextField(
                    controller: appNameController,
                    style: textStyle,
                    onChanged: (value) {                
                      updateAppname();
                      debugPrint('something changed');
                    },
                    decoration: InputDecoration(
                      labelText: 'App Name',
                      labelStyle: textStyle,
                      border: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(5.0) 
                      )
                    )
                  ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left:10.0, right: 10.0),
              child: TextField(
                controller: usernameController,
                style: textStyle,
                onChanged: (value) {
                  updateUsername();
                  debugPrint('something changed');
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: textStyle,
                  border: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(5.0) 
                  )
                )
              )
            ),
          
           Padding(
              padding: EdgeInsets.only(top: 15.0, left:10.0, right: 10.0),
              child: TextField(
                controller: passwordController,
                style: textStyle,
                onChanged: (value) {
                  updatePassword();
                  debugPrint('something changed');
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: textStyle,
                  border: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(5.0) 
                  )
                )
              )
            ),
           
            Padding(
              padding: EdgeInsets.only(top: 35.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _delete();
                          debugPrint('delete');
                        });
                      },
                    ),
                  ),

                  Container(width: 5.0,),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _save();
                          debugPrint('save');
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            
          ],
        )
      )     
    );
  }

  void updateAppname() {
    account.appname = appNameController.text;
  }
  
  void updateUsername() {
    account.username = usernameController.text;
  }
  
  void updatePassword() {
    account.password = passwordController.text;
  }

  void _save() async {
    int result;
    Navigator.pop(context, true);

    if (account.id != null) {
      result = await databaseHelper.updateAccount(account);
    } else {
      result = await databaseHelper.insertAccount(account);
    }

     result != 0
        ? _showAlertDialog('Status', "Account Saved")
        : _showAlertDialog('Status', "Error occoured");
  }

  //func to delete node
  void _delete() async {

    Navigator.pop(context, true);

    if (account.id == null) {
      _showAlertDialog("Status", "No account deleted");
    }

    //deletes the actual note if note id exits
    int result = await databaseHelper.deleteAccount(account);

    //showing a dialogue box based on the response var
    result != 0
        ? _showAlertDialog('Status', "Account deleted")
        : _showAlertDialog('Status', "Error occoured");
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }
}
