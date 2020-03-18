import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:password_manager/model/account.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper; //singleton
  static Database _database;

  String accountTable = 'account_table';
  String colId = 'id';
  String colAppname = 'appname';
  String colUsername = 'username';
  String colPassword = 'password';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
 
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'account.db';

    var accountDatabase = openDatabase(path, version:1, onCreate: _createDb);

    return accountDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $accountTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colAppname TEXT, $colUsername TEXT, $colPassword TEXT)');
  }

  Future<List<Map<String, dynamic>>> getAccountMapList() async {
    Database db = await this.database;

    var result = await db.query(accountTable, orderBy: '$colAppname ASC');

    return result;
  }

  Future<int> insertAccount(Account account) async {
    Database db = await this.database;

    var result = await db.insert(accountTable, account.toMap());

    return result;
  }
  
  Future<int> updateAccount(Account account) async {
    Database db = await this.database;

    var result = await db.update(accountTable, account.toMap(), where: '$colId = ?', whereArgs: [account.id]);

    return result;
  }

    
  Future<int> deleteAccount(Account account) async {
    Database db = await this.database;

    int result = await db.delete(accountTable, where: '$colId = ?', whereArgs: [account.id]);

    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;

    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT(*) FROM $accountTable');
    int result = Sqflite.firstIntValue(x);

    return result;
  }

  Future<List<Account>> getAccountList() async {
    var accountMapList = await getAccountMapList();
    int count = accountMapList.length;

    List<Account> accountList = List<Account>();

    for (int i = 0; i < count; i++) {
      accountList.add(Account.fromMapObject(accountMapList[i]));
    }

    return accountList;
  }
}