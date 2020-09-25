import 'package:flutter/material.dart';
import 'package:flutter_unit_test_acazia/blocs/bloc_provider.dart';
import 'package:flutter_unit_test_acazia/blocs/bloc_user.dart';
import 'package:flutter_unit_test_acazia/models/model_user.dart';
import 'package:flutter_unit_test_acazia/state/state_user.dart';
import 'package:flutter_unit_test_acazia/uis/common_widget/empty_widget.dart';
import 'package:flutter_unit_test_acazia/uis/common_widget/errors_widget.dart';
import 'package:flutter_unit_test_acazia/uis/common_widget/loading_widget.dart';
import 'package:flutter_unit_test_acazia/uis/ui_user/profile_user.dart';


class InitScreenUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocUser blocUser = BlocProvider.of<BlocUser>(context);
    return StreamBuilder(
      initialData: blocUser.userPopulated,
      stream: blocUser.stream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  EmptyWidget(visible: data is UserEmpty),
                  LoadingWidget(visible: data is UserEmpty),
                  ErrorsWidget(visible: data is UserError),
                  ScreenUserState(listUser: data is UserPopulated ? getListUser(data) : []),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  getListUser(UserPopulated userPopulated) {
    return userPopulated.listUser;
  }

}

class ScreenUserState extends StatelessWidget {

  final List<UserInfo> listUser;
  ScreenUserState({@required this.listUser});

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            _buildBackground(context),
            listUser.isNotEmpty ? _buildPageViewProfile() : Center(child: CircularProgressIndicator()),
          ],
        )
    );
  }

  _buildBackground(BuildContext context) {
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height / 4,
            color: Colors.black54),
        Container(
            color: Colors.white38
        )
      ],
    );
  }

  _buildPageViewProfile() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      controller: controller,
      itemCount: listUser.length,
      itemBuilder: (BuildContext context, int index) {
        return ProfileDetail(userInfo: listUser[index]);
      },
    );
  }

}