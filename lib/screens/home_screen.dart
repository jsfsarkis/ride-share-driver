import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Main Page'),
        ),
        body: MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          minWidth: 200,
          child: Text('Hello'),
        ),
      ),
    );
  }
}
