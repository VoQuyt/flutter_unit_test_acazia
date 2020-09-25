import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit_test_acazia/models/model_user.dart';
import 'package:flutter_unit_test_acazia/resources/database.dart';
import 'package:flutter_unit_test_acazia/uis/common_widget/line_circle.dart';

class ProfileDetail extends StatefulWidget {
  final UserInfo userInfo;
  ProfileDetail({@required this.userInfo});

  @override
  State<StatefulWidget> createState() => ProfileUser();

}

// ignore: must_be_immutable
class ProfileUser extends State<ProfileDetail> {

  int _selectedIndex = 0;
  bool islike = false;

  @override
  void InitState() {
    super.initState();
    //islike = widget.islike;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: MediaQuery.of(context).size.height / (5/4),
          width: MediaQuery.of(context).size.width / (5/4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  //color: Color(0xffA22447).withOpacity(.05),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: Stack(
            children: [
              _buildBackgroundPage(),
              _buildAvatar(),
              _buildUserInfo(),
              _buildBottomNavigation()
            ],
          ),
        )
    );
  }

  _buildBottomNavigation() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 40,), title: Text("")),
          BottomNavigationBarItem(icon: Icon(Icons.event, size: 40,), title: Text("")),
          BottomNavigationBarItem(icon: Icon(Icons.location_on, size: 40,), title: Text("")),
          BottomNavigationBarItem(icon: Icon(Icons.phone, size: 40,), title: Text("")),
          BottomNavigationBarItem(icon: Icon(Icons.lock_outline, size: 40,), title: Text("")),
        ],
      ),
    );
  }

  buildPageInfo(int index) {
    switch(index) {
      case 0:
        return _buildInfoPerson();
      case 1:
        return _buildInfoEvent();
      case 2:
        return _buildInfoLocation();
      case 3:
        return _buildInfoPhone();
      case 4:
        return _buildInfoAccount();
      default:
      //nothing
    }
  }

  _buildUserInfo() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
      child: Center(
        child: buildPageInfo(_selectedIndex),
      ),
    );
  }

  _buildInfoPerson() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("My name is", style: TextStyle(fontSize: 30, color: Colors.grey)),
              IconButton(
                  icon: Icon(
                    islike ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () async {
                    setState(() {
                      islike = !islike;
                    });
                    if(islike) {
                      var isExitUser = await DBProvider.db.isUserExit(widget.userInfo.id.value);
                      if(!isExitUser) {
                        await DBProvider.db.addUser(widget.userInfo);
                      } else {
                        print("user is exit");
                      }
                    } else {
                      await DBProvider.db.deleteUser(widget.userInfo.id.value);
                    }
                    print("like " + islike.toString());
                  })
            ],
          ),
          Text(widget.userInfo.name.first + " " + widget.userInfo.name.last, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Gender: ", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(widget.userInfo.gender, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
  _buildInfoEvent() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Event", style: TextStyle(fontSize: 30, color: Colors.grey)),
        ],
      ),
    );
  }
  _buildInfoLocation() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("My address is", style: TextStyle(fontSize: 30, color: Colors.grey)),
          Text(widget.userInfo.location.street, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  _buildInfoPhone() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Email: ", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(widget.userInfo.email, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("BPhone: ", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(widget.userInfo.phone, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("CPhone: ", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(widget.userInfo.cell, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
  _buildInfoAccount() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("UserName: ", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(widget.userInfo.login.username, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Register: ", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(widget.userInfo.registered, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  _buildAvatar() {
    return Container(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 5,
          top: MediaQuery.of(context).size.height / 10),
      child: DashedCircle(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: CircleAvatar(
            radius: 70.0,
            backgroundImage: NetworkImage(widget.userInfo.picture.large),
          ),
        ),
        gapSize: 0,
        color: Colors.grey,
      ),
    );
  }

  _buildBackgroundPage() {
    return Container(
      height: MediaQuery.of(context).size.height / (5 / 4) / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(5.0),
            topLeft: Radius.circular(5.0)),
        color: Colors.white24,
      ),
      alignment: Alignment.bottomCenter,
      child: Divider(
        thickness: 2,
      ),
    );
  }

}