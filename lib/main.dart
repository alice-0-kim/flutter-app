import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'search.dart';
import 'levels.dart';
import 'utility.dart';
import 'dart:async';
import 'dart:convert' show json;
import "package:http/http.dart" as http;
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
//      home: MyHomePage(title: 'Menu'),
      home: AnonHomePage(),
    );
  }
}

class AnonHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnonHomePageState();
}

class AnonHomePageState extends State<AnonHomePage> {
  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text('Browse'.toUpperCase(), style: TextStyle(letterSpacing: 1.0),),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search(title: "Browse")));
          },
        ),
        RaisedButton(
          child: Text('Levels'.toUpperCase(), style: TextStyle(letterSpacing: 1.0),),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ByLevels(title: "By Levels")));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Main menu"),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  }
}

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

GoogleSignInAccount currentUser;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        currentUser = account;
      });
    });
    googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    googleSignIn.disconnect();
  }

  Widget _buildBody() {
    if (currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // TODO: make it a snackbar, or popup
          Text("Welcome back, ${currentUser.displayName}!"),
          RaisedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
          RaisedButton(
            child: Text('Browse'.toUpperCase(), style: TextStyle(letterSpacing: 1.0),),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Search(title: "Browse")));
            },
          ),
          RaisedButton(
            child: Text('Levels'.toUpperCase(), style: TextStyle(letterSpacing: 1.0),),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ByLevels(title: "By Levels")));
            },
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          RaisedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(widget.title),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  }
}