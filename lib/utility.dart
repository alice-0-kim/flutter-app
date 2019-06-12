import 'package:flutter/material.dart';
import 'main.dart';
import 'constants.dart';

//enum Choice {
//  // TODO: replace filler options
//  Settings, Sound, Logout
//}

PreferredSizeWidget buildAppBar(String title) => AppBar(
  backgroundColor: Colors.white,
  elevation: 0.0,
  title: Text(title),
  actions: <Widget>[
    buildPopupMenuButton(),
  ],
);

List<PopupMenuItem<Choice>> buildPopupMenuItems() =>
    [Choice.Logout, Choice.Settings, Choice.Sound].map((choice){
      return PopupMenuItem<Choice>(
        value: choice,
        child: Text(choice.toString().split('.').last),
      );
    }).toList();

PopupMenuButton<Choice> buildPopupMenuButton() =>
    PopupMenuButton<Choice>(
      onSelected: (choice) => _handleSelected(choice),
      itemBuilder: (BuildContext context){
        return buildPopupMenuItems();
      },
    );

_handleSelected(Choice choice) {
  switch(choice) {
    case Choice.Settings:
      print(choice.toString().split('.').last);
      break;
    case Choice.Sound:
      print(choice.toString().split('.').last);
      break;
    case Choice.Logout:
      googleSignIn.disconnect();
      break;
  }
}