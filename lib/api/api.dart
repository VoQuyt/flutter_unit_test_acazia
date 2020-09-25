
import 'package:flutter_unit_test_acazia/models/model_user.dart';
import 'package:flutter_unit_test_acazia/resources/data.dart';

class API {
  //Singleton
  API._privateConstructor();

  static final API instance = API._privateConstructor();

  Future<ListUser> getDataUser() async {
    return ListUser.fromJson(data);
  }
}