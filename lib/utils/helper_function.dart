import 'package:flutter_unit_test_acazia/blocs/bloc_provider.dart';
import 'package:flutter_unit_test_acazia/blocs/bloc_user.dart';
import 'package:flutter_unit_test_acazia/uis/ui_user/screen_user.dart';

BlocProvider<BlocUser> getUserPopularProvider() {
  return BlocProvider<BlocUser> (
    child: InitScreenUser(),
    bloc: BlocUser(),
  );
}