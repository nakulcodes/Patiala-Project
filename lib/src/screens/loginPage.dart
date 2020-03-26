import 'package:flutter_login_signup/allFiles.dart';
import 'package:flutter_login_signup/src/screens/guestLogin.dart';

final nameContro = TextEditingController();
final passContro = TextEditingController();

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
  Bloc bloc = Bloc();
  int selectedRadio = 0;

  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  Widget _emailField(String title, {TextEditingController con}) {
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
          StreamBuilder<String>(
            stream: bloc.email,
            builder: (context, snapshot) => TextField(
              controller: con,
              onSubmitted: (e) {
                print(e);
              },
              onChanged: bloc.emailChanged,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  // hintText: "Enter email",
                  // labelText: "Email",
                  errorText: snapshot.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passField(String title,
      {bool isPassword = false, TextEditingController con}) {
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
          // TextFormField(
          //     controller: contr,
          //     obscureText: isPassword,
          //     decoration: InputDecoration(
          //         border: InputBorder.none,
          //         fillColor: Color(0xfff3f3f4),
          //         filled: true))
          StreamBuilder<String>(
            stream: bloc.password,
            builder: (context, snapshot) => TextField(
              controller: con,
              onSubmitted: (e) {
                print(e);
              },
              obscureText: true,
              onChanged: bloc.passwordChanged,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  // hintText: "Enter password",
                  // labelText: "password",
                  errorText: snapshot.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: StreamBuilder<bool>(
          stream: bloc.submitCheck,
          builder: (context, snapshot) {
            return ButtonTheme(
              minWidth: MediaQuery.of(context).size.width - 20.0,
              height: 100.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  // side: BorderSide(color: Colors.red)
                ),
                color: Color(0xfffe9263),
                onPressed: snapshot.hasData
                    ? () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        // LoginLoader(context, nameContro, passContro);
                        if (selectedRadio == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginLoaderUser(
                                      context, nameContro, passContro)));
                        } else if (selectedRadio == 1) {
                          print("YOu are a Manager...");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginLoaderManager(
                                      context, nameContro, passContro)));
                        }
                      }
                    : null,
                child: Text('Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            );
          }),
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
      child: Image(
        image: AssetImage("assets/images/road.png"),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _emailField("Email id", con: nameContro),
        _passField("Password", isPassword: true, con: passContro),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // key: _scaffoldKey,
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
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Container(
                          child: Row(
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
                      )),
                      // SizedBox(
                      //   height: 5,
                      // ),
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
