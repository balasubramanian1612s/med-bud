import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      double height = constraints.maxHeight;
      double width = constraints.maxWidth;

      return Scaffold(
        body: Container(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlineButton(
                onPressed: () {},
                child: Text('Login'),
                color: Colors.white,
                borderSide: BorderSide(color: Colors.pink),
              )
            ],
          ),
        ),
      );
    });
  }
}
