import 'package:image_picker/image_picker.dart';
import 'package:flutter_login_signup/allFiles.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:path_provider/path_provider.dart';

final snackBarRegister = SnackBar(
  content: Text("Registered Sucesfully"),
);
final snackBarErrorReg = SnackBar(
  content: Text("You have already registered"),
);
final snackBarRegisterManager = SnackBar(
  content: Text("You application is being Reviewed"),
);

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> scaffoldKeyReg =
      new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = new GlobalKey();
  int selectedRadio;

  bool _validate = false;
  String name, email, mobile, password, address;
  bool image;
  File _file;
  bool register;
  bool _image ;

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

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateAddress(String value) {
    if (value.length == 0) {
      return "Address is Required";
    } else if (value.length < 10) {
      return "Address must be more than 10 characters";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

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
      return "Password must have 1 Uppercase,1 Lowercase,1 numeric character \n& 1 special character";
    }
    return null;
  }

  Widget _nameField(String title) {
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
              validator: validateName,
              onSaved: (String val) {
                name = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
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
                email = val;
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
                password = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _numberField(String title) {
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
              maxLength: 10,
              keyboardType: TextInputType.number,
              validator: validateMobile,
              onSaved: (String val) {
                mobile = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _addressField(String title) {
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
              validator: validateAddress,
              onSaved: (String val) {
                address = val;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
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
              SystemChannels.textInput.invokeMethod('TextInput.hide');
             
              _sendToServer(context);
            },
            child: Text('Register',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ),
        ));
  }

  _sendToServer(BuildContext _context) async {
    if (_key.currentState.validate()) {
      // No any error in validation
      print("here");
      if (_file != null) {
         setState(() {
                register = true;
                _image = null;
              });
        _key.currentState.save();
        print("Name $name");
        print("Mobile $mobile");
        print("Email $email");
        print("Password is $password");
        print("Address is $address");
        print("Selected radio is $selectedRadio");
        print("Register Pressed");
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        // print(_file.lengthSync());

        final quality = 80;
        final tmpDir = (await getTemporaryDirectory()).path;
        final target =
            "$tmpDir/${DateTime.now().millisecondsSinceEpoch}-$quality.webp";

        final result = await FlutterImageCompress.compressAndGetFile(
          _file.path,
          target,
          format: CompressFormat.webp,
          minHeight: 300,
          minWidth: 300,
          quality: quality,
        );
        print(result.lengthSync());

        if (selectedRadio == 0) {
          registerUser(_context, name, email, mobile, password, address, result,
              register);
        } else if (selectedRadio == 1) {
          registerManager(_context, name, email, mobile, password, address,
              result, register);
        }
      }
      else{
        setState(() {
          _image = true;
        });
      }
    } else {
      if(_file==null){
        setState(() {
          _image = true;
        });
      }
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  void registerUser(
      BuildContext context1,
      String nameReg,
      String emailReg,
      String phoneReg,
      String passReg,
      String addReg,
      File _image,
      bool _register) async {
    String dataReg =
        '{"phone": "$phoneReg","name": "$nameReg","password":"$passReg","DOB":"null","email":"$emailReg","s3_link":"null","address":"$addReg"}';

    var responseReg =
        await http.post(userRegister, headers: headers, body: dataReg);
    String resp = responseReg.body;

    var respbody = json.decode(resp);
    print(respbody["status"]);
    if (responseReg.statusCode == 200) {
      if (respbody["status"] == "true") {
        print("Registered.....");

        ftpClient.connect();
        print(_image.path);

        try {
          print("Tryingg");
          ftpClient.changeDirectory("/Images/User/");
          ftpClient.makeDirectory(emailReg);
          ftpClient.changeDirectory(emailReg);

          ftpClient.uploadFile(_image);
        } catch (e) {
          print(e);
        } finally {
          ftpClient.disconnect();
        }
        setState(() {
          register = null;
        });

        dialog(
            context1,
            "You have sucessfully registered",
            Image.asset("assets/images/tick2.png"),
            () => Navigator.popAndPushNamed(context1, "loginPage"));
      }
      if (respbody["status"] == "false") {
        print("Error");
        setState(() {
          register = null;
        });
        dialog(
            context1,
            "You have already registered",
            Image.asset("assets/images/red2.png"),
            () => Navigator.popAndPushNamed(context1, "loginPage"));
      }
    }
  }

  void registerManager(
      BuildContext context1,
      String nameReg,
      String emailReg,
      String phoneReg,
      String passReg,
      String addReg,
      File _image,
      bool _register) async {
    // Scaffold.of(context).showSnackBar(snackBarRegister);
    // String nameReg = regNameData.text;
    // String emailReg = regEmailData.text.replaceAll(' ', '');
    // String phoneReg = regPhoneData.text.replaceAll(' ', '');
    // String passReg = regPassData.text.replaceAll(' ', '');
    // String addReg = regAddData.text;

    print("$nameReg+$emailReg+$phoneReg+$passReg");
    String dataReg =
        '{"phone": "$phoneReg","name": "$nameReg","password":"$passReg","DOB":"null","email":"$emailReg","s3_link":"null","address":"$addReg"}';

    var responseReg =
        await http.post(managerRegister, headers: headers, body: dataReg);
    String resp = responseReg.body;

    var respbody = json.decode(resp);
    print(respbody["status"]);
    print(respbody);

    if (responseReg.statusCode == 200) {
      // regNameData.clear();
      // regEmailData.clear();
      // regPhoneData.clear();
      // regPassData.clear();

      // regAddData.clear();
      if (respbody["status"] == "true") {
        print("Registered.....");
        // Scaffold.of(context1).showSnackBar(snackBarRegisterManager);
        // Duration(seconds: 2);
        ftpClient.connect();

        try {
          print("Tryingg");
          ftpClient.changeDirectory("/Images/Manager/");
          ftpClient.makeDirectory(emailReg);
          ftpClient.changeDirectory(emailReg);

          ftpClient.uploadFile(_image);
          // Duration(seconds: 4);
          // print(_image.path.split("/").last);
          // ftpClient.changeDirectory(emailReg);
          // ftpClient.rename(_image.path.split("/").last, emailReg);
        } finally {
          ftpClient.disconnect();
        }
        setState(() {
          register = null;
        });

        dialog(
            context1,
            "You will recieve mail shortly",
            Image.asset("assets/images/tick2.png"),
            () => Navigator.popAndPushNamed(context, "loginPage"));
      }
    }
    if (respbody["status"] == "false") {
      print("Error");
      setState(() {
        register = null;
      });
      dialog(
          context1,
          "You have already registered",
          Image.asset("assets/images/red2.png"),
          () => Navigator.popAndPushNamed(context, "loginPage"));
      // Builder(builder: (context1) => Scaffold.of(context1).showSnackBar(snackBarRegister),);

    }
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _nameField("Name"),
        _emailField("Email"),
        _numberField("Mobile Number"),
        _addressField("Address"),
        _passField("Password"),
        register == null
            ? Container(
                child: Row(
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
              )
            : CircularProgressIndicator(
                value: null,
                strokeWidth: 5.0,
              ),
      ],
      // ),
    );
  }

  void _choose() async {
    _file = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);

    if (_file == null) {
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
                      GestureDetector(
                        onTap: _choose,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xfffe9263),
                          // backgroundImage: file==null?null:Image.file(file),
                          child: image == null
                              ? Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 50,
                                )
                              : ClipRRect(
                                  borderRadius:
                                      new BorderRadius.circular(100.0),
                                  child: Image.file(
                                    _file,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                       _image == null ? "Click Image" : "Upload your Photo",
                        style: TextStyle(
                            color:
                                _image == true ? Colors.red : Colors.black,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Form(
                          key: _key,
                          autovalidate: _validate,
                          child: _emailPasswordWidget()),
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
