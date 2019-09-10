import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class RegisterPage extends StatelessWidget {
  final appTitle = 'Sign up page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: signUpForm(),
      ),
    );
  }
}

class signUpForm extends StatefulWidget {
  @override
  signUpFormState createState() {
    return signUpFormState();
  }
}

class signUpFormState extends State<signUpForm> {
  String _email, _password;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Text(
                'Create Account',
                style: style.copyWith(fontSize: 50, color: Colors.blue),
              ),
            ),
            _showFirstNameInput(),
            SizedBox(height: 20.0),
            _showLastNameInput(),
            SizedBox(height: 20.0),
            _showEmailInput(),
            SizedBox(height: 20.0),
            _showPasswordInput(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: _showRegisterButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showFirstNameInput() {
    return TextFormField(
      //First name form field
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'First name',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget _showLastNameInput() {
    return TextFormField(
      //Last name form field
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Last name',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget _showEmailInput() {
    return TextFormField(
      //Email ID form
      validator: (input) {
        if (input.isEmpty) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (input) => _email = input.trim(),
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Email ID',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget _showPasswordInput() {
    return TextFormField(
      //Password form
      validator: (value) {
        if (value.length < 5) {
          return 'You password needs to be atleast 5 characters';
        }
        return null;
      },
      onSaved: (value) => _password = value.trim(),
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Password',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget _showRegisterButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.lightBlue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          signUp();
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Route _loginRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.fastLinearToSlowEaseIn;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Future<void> signUp() async {
    try {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(_loginRoute());
      }
    } catch (e) {
    
    }
  }
}
