import 'package:flutter_login_signup/allFiles.dart';
import 'package:flutter_login_signup/src/screens/guestLogin.dart';
import 'package:url_launcher/url_launcher.dart';

final snackBarLogin = SnackBar(
  content: Text("Wrong Credentials.."),
);

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Bloc bloc = Bloc();
  int selectedRadio = 0;

  final GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  _launchURL() async {
    const url = 'https://hlmt.herokuapp.com/user/forgot';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _emaill;
  String _password;

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    RegExp regExp = new RegExp(
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");
    if (value.length == 0) {
      return "Password is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Password is Required";
    }
    return null;
  }

  Widget _emailField(String title) {
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
            height: 5,
          ),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
              onSaved: (String val) {
                _emaill = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _passField(String title) {
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
            height: 5,
          ),
          TextFormField(
              validator: validatePassword,
              keyboardType: TextInputType.text,
              obscureText: true,
              onSaved: (String val) {
                _password = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  // String validateEmail(String value) {

  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value.length == 0) {
  //     return "Email is Required";
  //   } else if (!regExp.hasMatch(value)) {
  //     return "Invalid Email";
  //   } else {
  //     return null;
  //   }
  // }

  // String validatePassword(String value) {
  //   RegExp regExp = new RegExp(
  //       "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");
  //   if (value.length == 0) {
  //     return "Password is Required";
  //   } else if (!regExp.hasMatch(value)) {
  //     return "Password is Required";
  //   }
  //   return null;
  // }

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
              sendToServer();
            },
            child: Text('Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ),
        ));
  }

  void sendToServer() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (_key.currentState.validate()) {
      _key.currentState.save();
      // No any error in validation
      if (selectedRadio == 0) {
        print(_emaill);
        print(_password);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginLoaderUser(context, _emaill, _password)));
      } else if (selectedRadio == 1) {
        print("YOu are a Manager...");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginLoaderManager(context, _emaill, _password)));
      }
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
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
              context, MaterialPageRoute(builder: (context) => GuestLogin())),
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
      child: Hero(tag: 'logo', child: Image.asset("assets/images/road.png")),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _emailField(
          "Email id",
        ),
        _passField("Password"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: selectedRadio,
                    onChanged: (val) {
                      print(val);
                      setSelectedRadio(val);
                    },
                  ),
                  Text("User"),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (val) {
                      print(val);
                      setSelectedRadio(val);
                    },
                  ),
                  Text("Manager"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
              child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height-100,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _title(),
                        Form(
                            key: _key,
                            autovalidate: _validate,
                            child: _emailPasswordWidget()),
                        _submitButton(),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _launchURL,
                            child: Text('Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        _divider(),
                        _guestSignUp(),
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
      ),
    );
  }
}
