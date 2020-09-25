import 'package:flutter/material.dart';

class ErrorsWidget extends StatelessWidget {
  final bool visible;

  final error;

  const ErrorsWidget({Key key, this.visible, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: visible ? 1.0 : 0.0,
      child: Container(
        alignment: FractionalOffset.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.signal_wifi_off, color: Colors.green, size: 50.0,),
            Container(
              padding: EdgeInsets.only(top: 16.0),
              child: Text('Connect unsuccessful'),
            )
          ],
        ),
      ),
    );
  }
}
