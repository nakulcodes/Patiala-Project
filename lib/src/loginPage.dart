import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/dashboard.dart';
import 'package:flutter_login_signup/src/signup.dart';

final nameContro = TextEditingController();
final passContro = TextEditingController();

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _date = "Not set";
  String _time = "Not set";

  Widget _entryField(String title,
      {bool isPassword = false, TextEditingController contr}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: contr,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width - 20.0,
        height: 100.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            // side: BorderSide(color: Colors.red)
          ),
          color: Color(0xfffe9263),
          onPressed: () {
            print("Name:$nameContro,Pass:$passContro");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          },
          child: Text('Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget _guestSignUp() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width - 20.0,
        height: 100.0,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            // side: BorderSide(color: Colors.red)
          ),
          color: Color(0xfffe9263),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpPage())),
          child: Text('Guest Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              print(MediaQuery.of(context).size);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      height: 200,
      width: 200,
      child: Image(
        image: AssetImage("assets/images/road.png"),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email id", contr: nameContro),
        _entryField("Password", isPassword: true, contr: passContro),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height-100,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      _title(),
                      SizedBox(
                        height: 10,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      _submitButton(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => print("Forgot Password"),
                          child: Text('Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      _divider(),
                      _guestSignUp(),
                      // Expanded(
                      //   flex: 1,
                      //   child: SizedBox(),
                      // ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _createAccountLabel(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
