import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  color: Colors.pink[50],
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {},
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.pink[500], fontSize: 15),
              ),
            ),
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.pink[300],
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            // SizedBox(
            //   height: 130,
            // ),
            // Text('New User? Create Account')
          ],
        ),
      ),
    );
  }
}