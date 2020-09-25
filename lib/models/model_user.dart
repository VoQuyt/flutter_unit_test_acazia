

class ListUser {
  List<UserInfo> _results = [];
  Info _info;
  bool get isEmpty => !hasResults();
  hasResults() {
    return _results != null && _results.length > 0;
  }

  ListUser.fromJson(Map<String , dynamic> parseJson) {
    //print(parseJson.toString());
    _info = new Info(parseJson['info']);
    for(var i = 0 ; i < parseJson['results'].length; i++) {
      UserInfo userInfo = new UserInfo(parseJson['results'][i]);
      _results.add(userInfo);
    }
  }

  List<UserInfo> get results => _results;
  Info get info => _info;
}

class UserInfo {
  String _gender;
  Name _name;
  Location _location;
  String _email;
  Login _login;
  String _dob;
  String _registered;
  String _phone;
  String _cell;
  Id _id;
  Picture _picture;
  String _nat;

  UserInfo.fromMap(Map<String , dynamic> userInfo) {
    _gender = userInfo['gender'];
    _name = new Name.fromDB(userInfo['first_name'], userInfo['last_name']);
    _location = new Location.fromDB(userInfo['street']);
    _email = userInfo['email'];
    _login =  new Login.fromDB(userInfo['username']);
    _registered = userInfo['registered'];
    _phone = userInfo['phone'];
    _cell = userInfo['cell'];
    _id = Id.fromDB(userInfo['id']);
    _picture = Picture.fromDB(userInfo['large']);
  }

  UserInfo(userInfo) {
    _gender = userInfo['gender'];
    _name = new Name(userInfo['name']);
    _location = new Location(userInfo['location']);
    _email = userInfo['email'];
    _login =  new Login(userInfo['login']);
    _dob = userInfo['dob'];
    _registered = userInfo['registered'];
    _phone = userInfo['phone'];
    _cell = userInfo['cell'];
    _id = Id(userInfo['id']);
    _picture = Picture(userInfo['picture']);
    _nat = userInfo['nat'];
  }

    String get gender => _gender;
    Name get name => _name;
    String get nat => _nat;
    Picture get picture => _picture;
    Id get id => _id;
    String get cell => _cell;
    String get phone => _phone;
    String get registered => _registered;
    String get dob => _dob;
    Login get login => _login;
    String get email => _email;
    Location get location => _location;
}

// ignore: camel_case_types
class Name {
  String _title;
  String _first;
  String _last;

  Name.fromDB(String firstname, String lastname){
    _first = firstname;
    _last = lastname;
  }

  Name(name) {
    _title = name['title'];
    _first = name['first'];
    _last = name['last'];
  }

  String get title => _title;
  String get first => _first;
  String get last => _last;
}

// ignore: camel_case_types
class Location {
  String _street;
  String _city;
  String _state;
  int _postcode;

  Location.fromDB(String street) {
    _street = street;
  }

  Location(location) {
    _street = location['street'];
    _city = location['city'];
    _state = location['state'];
    _postcode = location['postcode'];
  }

  String get street => _street;
  String get city => _city;
  String get state => _state;
  int get postcode => _postcode;
}

// ignore: camel_case_types
class Login {
  String _username;
  String _password;
  String _salt;
  String _md5;
  String _sha1;
  String _sha256;

  Login.fromDB(String username){
    _username = username;
  }

  Login(login) {
    _username = login['username'];
    _password = login['password'];
    _salt = login['salt'];
    _md5 = login['md5'];
    _sha1 = login['sha1'];
    _sha256 = login['sha256'];
  }

  String get username => _username;
  String get password => _password;
  String get salt => _salt;
  String get md5 => _md5;
  String get sha1 => _sha1;
  String get sha256 => _sha256;
}

// ignore: camel_case_types
class Id {
  String _name;
  String _value;

  Id.fromDB(String value){
    _value = value;
  }

  Id(id) {
    _name = id['name'];
    _value = id['value'];
  }

  String get name => _name;
  String get value => _value;
}

// ignore: camel_case_types
class Picture {
  String _large;
  String _medium;
  String _thumbnail;

  Picture.fromDB(String larger){
    _large = larger;
  }

  Picture(picture) {
    _large = picture['large'];
    _medium = picture['medium'];
    _thumbnail = picture['thumbnail'];
  }

  String get large => _large;
  String get medium => _medium;
  String get thumbnail => _thumbnail;
}

// ignore: camel_case_types
class Info {
  String _seed;
  int _result;
  int _page;
  String _version;

  Info(info){
    _seed = info['seed'];
    _result = info['result'];
    _page = info['page'];
    _version = info['version'];
  }

  String get seed => _seed;
  int get result => _result;
  int get page => _page;
  String get version => _version;
}