class Account {
  int _id;
  String _appname;
  String _username;
  String _password;

  Account(this._appname, this._username, this._password);
  
  Account.withId(this._id, this._appname, this._username, this._password);

  int get id => _id;

  String get appname => _appname;

  String get username => _username;

  String get password => _password;

  set appname(String newAppname) {
    this._appname = newAppname;
  }

  set username(String newUsername) {
    this._username = newUsername;
  }

  set password(String newPassword) {
    this._password = newPassword;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    
    map['appname'] = _appname;
    map['username'] = _username;
    map['password'] = _password;

    return map;
  }

  Account.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._appname = map['appname'];
    this._username = map['username'];
    this._password = map['password'];
  }
}