import 'package:flutter_login_signup/allFiles.dart';

final snackBarRegister = SnackBar(
  content: Text("Registered Sucesfully"),
);
final snackBarError = SnackBar(
  content: Text("You have already registered"),
);
TextEditingController regName = TextEditingController();
TextEditingController regEmail = TextEditingController();
TextEditingController regPhone = TextEditingController();
TextEditingController regPass = TextEditingController();
Bloc bloc1 = Bloc();

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> scaffoldKeyReg =
      new GlobalKey<ScaffoldState>();
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title,
      {bool isPassword = false, TextEditingController contro}) {
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
          TextField(
              controller: contro,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
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
            stream: bloc1.email,
            builder: (context, snapshot) => TextField(
              controller: con,
              onSubmitted: (e) {
                print(e);
              },
              onChanged: bloc1.emailChanged,
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
            stream: bloc1.password,
            builder: (context, snapshot) => TextField(
              controller: con,
              onSubmitted: (e) {
                print(e);
              },
              obscureText: true,
              onChanged: bloc1.passwordChanged,
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

  Widget _numberField(String title, {TextEditingController con}) {
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
            stream: bloc1.number,
            builder: (context, snapshot) => TextField(
              controller: con,
              onSubmitted: (e) {
                print(e);
              },
              onChanged: bloc1.numberChanged,
              keyboardType: TextInputType.number,
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

  Widget _submitButton(BuildContext context) {
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
            print("Register Pressed");
            SystemChannels.textInput.invokeMethod('TextInput.hide');

            registerUser(context, regName, regEmail, regPhone, regPass);
            // Scaffold.of(context).showSnackBar(snackBarRegister);
          },
          child: Text('Register',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }

  // Widget _loginAccountLabel() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 20),
  //     alignment: Alignment.bottomCenter,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text(
  //           'Already have an account ?',
  //           style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
  //         ),
  //         SizedBox(
  //           width: 10,
  //         ),
  //         InkWell(
  //           onTap: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => LoginPage()));
  //           },
  //           child: Text(
  //             'Login',
  //             style: TextStyle(
  //                 color: Color(0xfff79c4f),
  //                 fontSize: 13,
  //                 fontWeight: FontWeight.w600),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

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
        _entryField("Name", contro: regName),
        _emailField("Email id", con: regEmail),
        _numberField("Phone Number", con: regPhone),
        _passField("Password", isPassword: true, con: regPass),
        // _entryField("Phone Number"),
        // _entryField("Email id"),
        // _entryField("Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: 
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                      _title(),
                      // SizedBox(
                      //   height: 50,
                      // ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _submitButton(context),
                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: _loginAccountLabel(),
                // ),
                Positioned(top: 40, left: 0, child: _backButton()),
                // Positioned(
                //     top: -MediaQuery.of(context).size.height * .15,
                //     right: -MediaQuery.of(context).size.width * .4,
                //     child: BezierContainer())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
