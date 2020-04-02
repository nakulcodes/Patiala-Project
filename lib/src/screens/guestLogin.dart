import 'package:flutter_login_signup/allFiles.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

final TextEditingController _guestName = TextEditingController();
final TextEditingController _guestEmail = TextEditingController();
final TextEditingController _guestNumber = TextEditingController();
final TextEditingController _guestAdd = TextEditingController();
Bloc bloc1 = new Bloc();
final snackBarErrorGuest = SnackBar(
  content: Text("Error! Try Again Later"),
);

class GuestLogin extends StatefulWidget {
  @override
  _GuestLoginState createState() => _GuestLoginState();
}

class _GuestLoginState extends State<GuestLogin> {
  File file;
  bool image;
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
            print("Guest Login Pressed");
            // SystemChannels.textInput.invokeMethod('TextInput.hide');
            sendGuestData(context, _guestName, _guestEmail, _guestNumber,_guestAdd,file);
            // file.delete();

            // Scaffold.of(context).showSnackBar(snackBarRegister);
          },
          child: Text('Guest Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
        ),
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

  Widget _nameField(String title, {TextEditingController contro}) {
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
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
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
              maxLength: 10,
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

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _nameField("Name", contro: _guestName),

        _emailField("Email id", con: _guestEmail),
        _numberField("Phone Number", con: _guestNumber),
        _nameField("Address",contro:_guestAdd)

        // _entryField("Phone Number"),
        // _entryField("Email id"),
        // _entryField("Password", isPassword: true),
      ],
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Builder(
  //       builder: (context) => SingleChildScrollView(
  //         child: Container(
  //           margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
  //           height: MediaQuery.of(context).size.height,
  //           child: Stack(
  //             children: <Widget>[
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 20),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: <Widget>[
  //                     Expanded(
  //                       flex: 3,
  //                       child: SizedBox(),
  //                     ),
  //                     _title(),
  //                     _emailPasswordWidget(),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     _submitButton(context),
  //                     Expanded(
  //                       flex: 2,
  //                       child: SizedBox(),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               Positioned(top: 40, left: 0, child: _backButton()),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
            child: Stack(children: <Widget>[
              Positioned(top: 0, left: 0, child: _backButton()),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Positioned(child: _backButton(),top: 5,left: 5,),
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
                                  borderRadius:
                                      new BorderRadius.circular(100.0),
                                  child: Image.file(
                                    file,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _emailPasswordWidget(),
                      _submitButton(context),
                    ]),
              ),
            ]),
          ),
        ),
        // ),
      ),
    );
  }
}
