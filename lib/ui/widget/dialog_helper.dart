import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static showLoginDialog(context,String title) async {
    return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text("暂未登陆"),
              actions: <Widget>[
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: new Text(
                    "取消",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                CupertinoButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                  },
                  child: new Text("确认", style: TextStyle(color: Colors.black)),
                ),
              ],
            ));
  }
}
