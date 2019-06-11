import 'package:flutter/material.dart';

enum Choice {
  Settings, Sound, Logout
}

List<PopupMenuItem<Choice>> buildPopupMenuItems() =>
    [Choice.Logout, Choice.Settings, Choice.Sound].map((choice){
      return PopupMenuItem<Choice>(
        value: choice,
        child: Text(choice.toString().split('.').last),
      );
    }).toList();

PopupMenuButton<Choice> buildPopupMenuButton() =>
    PopupMenuButton<Choice>(
      onSelected: (choice) => print(choice.toString().split('.').last),
      itemBuilder: (BuildContext context){
        return buildPopupMenuItems();
      },
    );