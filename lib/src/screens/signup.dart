// import 'dart:html';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_login_signup/allFiles.dart';
import 'dart:io';
import 'dart:convert';

final snackBarRegister = SnackBar(
  content: Text("Registered Sucesfully"),
);
final snackBarErrorReg = SnackBar(
  content: Text("You have already registered"),
);
final snackBarRegisterManager = SnackBar(
  content: Text("You application is being Reviewed"),
);
TextEditingController _regName = TextEditingController();
TextEditingController _regEmail = TextEditingController();
TextEditingController _regPhone = TextEditingController();
TextEditingController _regPass = TextEditingController();
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
  int selectedRadio;

  bool image;
  File file;

  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

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
            height: 5,
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
            height: 5,
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
            height: 5,
          ),
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
            height: 5,
          ),
          StreamBuilder<String>(
            stream: bloc1.number,
            builder: (context, snapshot) => TextField(
              controller: con,
              onSubmitted: (e) {
                print(e);
              },
              maxLength: 10,
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

            if (selectedRadio == 0) {
              // print(file.path);
              registerUser(
                  context, _regName, _regEmail, _regPhone, _regPass, file);
            } else if (selectedRadio == 1) {
              registerManager(
                  context, _regName, _regEmail, _regPhone, _regPass, file);
            }

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

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Name", contro: _regName),
        _emailField("Email id", con: _regEmail),
        _numberField("Phone Number", con: _regPhone),
        _passField("Password", isPassword: true, con: _regPass),
        _entryField(
          "Address",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
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
            Row(
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
          ],
        ),
      ],
      // ),
    );
  }

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.camera);
    if (file == null) {
      return;
    } else {
      setState(() {
        image = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _choose,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xfffe9263),
                        // backgroundImage: file==null?null:Image.file(file),
                        child: image == null
                            ? Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 50,
                              )
                            : ClipRRect(
                                borderRadius: new BorderRadius.circular(100.0),
                                child: Image.file(
                                  file,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    _emailPasswordWidget(),
                    _submitButton(context),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
//  if(file==null)return null;
//             Expanded(
//               flex: 2,
//               child: SizedBox(),
//             ),
//           ],
//         ),
//       ),
// Positioned(top: 40, left: 0, child: _backButton()),
//       ],
//       ),
//       ),
//             ),
//           ),
//     ),
//   );
// }
//   return SafeArea(
//     child: Scaffold(
//       resizeToAvoidBottomPadding: false,
//       body: Stack(
//         children: <Widget>[
//           Positioned(top: 10, left: 3, child: _backButton()),
//           Positioned(
//             top: 30,
//            left:100,
//             child: Text("Register Here"),
//           ),
//           Container(
//             // child: SingleChildScrollView(
//               child: Positioned(
//                 // top: 95,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   // color: Colors.blueAccent,
//                   padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
//                   // child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       _emailPasswordWidget(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           // ),

//           // Positioned(
//           //   child: _submitButton(context),
//           //   bottom: 5,
//           //   right: 20,
//           //   left: 20,
//           // ),
//           // )
//         ],
//       ),
//     ),
//   );
//   // );

//   // }
//      }

// }
