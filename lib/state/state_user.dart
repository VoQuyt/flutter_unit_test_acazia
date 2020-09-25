
import 'package:flutter_unit_test_acazia/models/model_user.dart';

class UserState {
  UserState();
}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String error;
  UserError(this.error);
}

class UserNoResults extends UserState {}

class UserPopulated extends UserState {
  final List<UserInfo> listUser;

  update({List<UserInfo> newListUser}) {
    return this..listUser.addAll(newListUser ?? this.listUser);
  }

  UserPopulated(this.listUser);
}

class UserEmpty extends UserState {}