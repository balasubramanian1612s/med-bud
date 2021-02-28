import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name, email, address, pwd;
  String phoneNo;
  final formKey = GlobalKey<FormState>();
  bool validated = false;
  bool autoValidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value;
                  },
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
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    pwd = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    address = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill out this field';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneNo = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile Number',
                  ),
                ),
              ),
              // ignore: deprecated_member_use

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.pink[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      formKey.currentState.validate();
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        print(name);
                        print(address);
                        print(email);
                        print(pwd);
                        print(phoneNo);
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
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
      ),
    );
  }
}
