import 'package:flutter/material.dart';
import 'package:login_app/Api/Api.dart';
import 'package:login_app/src/secondView.dart';

//Colores
Color color1 = Colors.green;
Color color2 = Colors.grey;

//estilos
TextStyle placeHolderStyle = TextStyle(
  color: color2,
  fontSize: 15,
);

//controllers
final TextEditingController textFieldLoginController = TextEditingController();
final TextEditingController passFieldLoginController = TextEditingController();

class MyLogin extends StatelessWidget {
  const MyLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text.rich(TextSpan(
                  text: 'Hello\nThere',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: '.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color1,
                            fontSize: 60))
                  ])),
            ),
            TextFields(
              text: 'Email',
              style: placeHolderStyle,
              controller: textFieldLoginController,
              obscureText: false,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            TextFields(
                text: 'Password',
                style: placeHolderStyle,
                controller: passFieldLoginController,
                obscureText: true),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Container(
              child: LinkText(
                text: 'Forgot Password',
                fontSize: 15,
              ),
              padding: EdgeInsets.fromLTRB(195, 0, 0, 20),
            ),
            LoginButton(
              text: Text(
                'LOGIN',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            RegisterButton(
              text: Text('Log in with Facebook'),
              color: Colors.white,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(90, 15, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text('New to Spotify? '),
                    LinkText(
                      text: 'Register',
                      fontSize: 13,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  String text;
  TextStyle style;
  TextEditingController controller;
  bool obscureText;

  TextFields({this.text, this.style, this.controller, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      obscureText: obscureText,
      decoration: InputDecoration(hintText: text, hintStyle: placeHolderStyle),
      controller: controller,
    );
  }
}

class LinkText extends StatelessWidget {
  String text;
  double fontSize;

  LinkText({this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color1,
          fontSize: fontSize,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold),
    );
  }
}

class LoginButton extends StatelessWidget {
  Text text;
  Color color;
  String data;

  LoginButton({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 50.0,
        height: 50.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: EdgeInsets.fromLTRB(135, 0, 0, 0),
          color: color,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[text],
          ),
          onPressed: () {
            data = '{ "email": "' +
                textFieldLoginController.text +
                '","password": "' +
                passFieldLoginController.text +
                '" }';
            Api.login(data).then((sucess) {
              if (sucess) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondView()));
              } else {
                showDialog(
                    builder: (context) => AlertDialog(
                          title: Text('error al iniciar sesion'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Ok'),
                            )
                          ],
                        ),
                    context: context);
                return;
              }
            });
          },
        ));
  }
}

class RegisterButton extends StatelessWidget {
  Text text;
  Color color;
  RegisterButton({
    this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 50.0,
        height: 50.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.black, width: 2)),
          padding: EdgeInsets.fromLTRB(75, 0, 0, 0),
          color: color,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'f  ',
                style: TextStyle(fontSize: 25),
              ),
              text
            ],
          ),
          onPressed: () {},
        ));
  }
}
