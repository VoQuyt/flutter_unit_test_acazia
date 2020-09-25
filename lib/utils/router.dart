import 'package:flutter/material.dart';
import 'package:flutter_unit_test_acazia/blocs/bloc_provider.dart';
import 'package:flutter_unit_test_acazia/blocs/bloc_user.dart';
import 'package:flutter_unit_test_acazia/uis/ui_user/screen_user.dart';
import 'package:flutter_unit_test_acazia/uis/ui_user/screen_user_favorite.dart';
import 'package:flutter_unit_test_acazia/utils/slide_router.dart';

class Router {
  //Singleton
  Router._privateConstructor();

  static final Router instance = Router._privateConstructor();

  void goToScreenFavoriteUser(BuildContext context) {
    Navigator.push(
      context,
      RouteTransition(
        widget: ScreenUserFavorite(),
      ),
    );
  }

  void goToUserOnline(BuildContext context) {
    Navigator.push(
      context,
      RouteTransition(
        widget: BlocProvider<BlocUser>(
          bloc: BlocUser(),
          child: InitScreenUser(),
        ),
      ),
    );
  }
}