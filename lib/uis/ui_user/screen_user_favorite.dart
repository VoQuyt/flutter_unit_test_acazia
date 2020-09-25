import 'package:flutter/material.dart';
import 'package:flutter_unit_test_acazia/common_widget/empty_widget.dart';
import 'package:flutter_unit_test_acazia/models/model_user.dart';
import 'package:flutter_unit_test_acazia/resources/database.dart';
import 'package:flutter_unit_test_acazia/uis/ui_user/profile_user.dart';

class ScreenUserFavorite extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenUserFavoriteState();
}

class ScreenUserFavoriteState extends State<ScreenUserFavorite> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite User")),
      body: FutureBuilder<List<UserInfo>>(
        future: DBProvider.db.getAllUser(),
        builder: (BuildContext context, AsyncSnapshot<List<UserInfo>> snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.isEmpty) {
              return EmptyWidget(visible: true);
            }
            return PageView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                UserInfo userInfo = snapshot.data[index];
                return ProfileDetail(userInfo: userInfo);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

}