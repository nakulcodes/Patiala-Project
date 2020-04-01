import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_login_signup/allFiles.dart';

class LoginLoaderUser extends StatefulWidget {
  BuildContext context;
  TextEditingController _nameContro;
  TextEditingController _passContro;

  LoginLoaderUser(this.context, this._nameContro, this._passContro);

  @override
  _LoginLoaderUserState createState() => _LoginLoaderUserState();
}

class _LoginLoaderUserState extends State<LoginLoaderUser> {
  void loginCheck() async {
    print("Coming.........");
    String name = widget._nameContro.text.replaceAll(' ','');
    String pass = widget._passContro.text.replaceAll(' ','');
    String data = '{"email":"$name","password":"$pass"}';

    var response = await http.post(userLogin, headers: headers, body: data);
    print(response.body);
    String resp = response.body;

    var respbody = json.decode(resp);

    print(respbody["status"]);
    setUser(respbody, true);
    setTitle("reg_user");
    if (response.statusCode == 200) {
      if (respbody["status"] == "true") {
        widget._nameContro.clear();
        widget._passContro.clear();

        // print(person.namee);

        Navigator.push(widget.context,
            MaterialPageRoute(builder: (context) => NavigationBar()));
      } else if (respbody["status"] == "false") {
        // print(person.namee);
        Navigator.pop(context);
        // Scaffold.of(widget.context).showSnackBar(snackBarLogin);

        print("Error is Dashboard moving......");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ColorLoader5(),
      ),
    );
  }
}

class LoginLoaderManager extends StatefulWidget {
  BuildContext context;
  TextEditingController _nameContro;
  TextEditingController _passContro;

  LoginLoaderManager(this.context, this._nameContro, this._passContro);
  @override
  _LoginLoaderManagerState createState() => _LoginLoaderManagerState();
}

class _LoginLoaderManagerState extends State<LoginLoaderManager> {
  void managerLoginCheck() async {
    print("Coming......... inside Manager Login Check");
    String name = widget._nameContro.text;
    String pass = widget._passContro.text;
    String data = '{"email":"$name","password":"$pass"}';

    var response = await http.post(managerLogin, headers: headers, body: data);
    print(response.body);
    String resp = response.body;

    var respbody = json.decode(resp);

    print(respbody["status"]);
    setUser(respbody, true);

    if (response.statusCode == 200) {
      if (respbody["status"] == "true") {
        widget._nameContro.clear();
        widget._passContro.clear();
        setBank(respbody["bank_id"]);
        setMobileManager(respbody["phone"]);
        setBankLocation(respbody["location"]);
        setAvailHel(respbody["available_helmets"]);
        setTotalHel(respbody["total_helmets"]);
        setName(respbody["name"]);

        // print(person.namee);

        Navigator.push(widget.context,
            MaterialPageRoute(builder: (context) => ManagerDashboard()));

            // Navigator.pushReplacementNamed(context, )
      } else if (respbody["status"] == "false") {
        // print(person.namee);
        Navigator.pop(context);
        // Scaffold.of(widget.context).showSnackBar(snackBarLogin);

        print("Error is Dashboard moving......");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    managerLoginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ColorLoader5(),
      ),
    );
  }
}

void registerUser(
    BuildContext context1,
    TextEditingController regNameData,
    TextEditingController regEmailData,
    TextEditingController regPhoneData,
    TextEditingController regPassData,
    File _image) async {
  // Scaffold.of(context).showSnackBar(snackBarRegister);
  String nameReg = regNameData.text;
  String emailReg = regEmailData.text.replaceAll(' ', '');
  String phoneReg = regPhoneData.text;
  String passReg = regPassData.text.replaceAll(' ', '');

  print("$nameReg+$emailReg+$phoneReg+$passReg");
  String dataReg =
      '{"phone": "$phoneReg","name": "$nameReg","password":"$passReg","DOB":"null","email":"$emailReg","s3_link":"null"}';

  var responseReg =
      await http.post(userRegister, headers: headers, body: dataReg);
  String resp = responseReg.body;

  var respbody = json.decode(resp);
  print(respbody["status"]);
  if (responseReg.statusCode == 200) {
    regNameData.clear();
    regEmailData.clear();
    regPhoneData.clear();
    regPassData.clear();
    if (respbody["status"] == "true") {
      print("Registered.....");
      Scaffold.of(context1).showSnackBar(snackBarRegister);
      ftpClient.connect();
      print(_image.path);
      try {
        print("Tryingg");
        ftpClient.changeDirectory("/Images/User/");
        ftpClient.makeDirectory(emailReg);
        ftpClient.changeDirectory(emailReg);

        ftpClient.uploadFile(_image);
        // Duration(seconds: 4);
        // print(_image.path.split("/").last);
        // ftpClient.changeDirectory(emailReg);
        // ftpClient.rename(_image.path.split("/").last, emailReg);
      } finally {
        ftpClient.disconnect();
            _image.delete();
      }
  
      Navigator.pop(context1);
    }
    if (respbody["status"] == "false") {
      print("Error");
      Scaffold.of(context1).showSnackBar(snackBarErrorReg);
      // Builder(builder: (context1) => Scaffold.of(context1).showSnackBar(snackBarRegister),);

    }
  }
}

void registerManager(
    BuildContext context1,
    TextEditingController regNameData,
    TextEditingController regEmailData,
    TextEditingController regPhoneData,
    TextEditingController regPassData,
    File _image) async {
  // Scaffold.of(context).showSnackBar(snackBarRegister);
  String nameReg = regNameData.text;
  String emailReg = regEmailData.text;
  String phoneReg = regPhoneData.text;
  String passReg = regPassData.text;

  print("$nameReg+$emailReg+$phoneReg+$passReg");
  String dataReg =
      '{"phone": "$phoneReg","name": "$nameReg","password":"$passReg","DOB":"null","email":"$emailReg","s3_link":"null"}';

  var responseReg =
      await http.post(managerRegister, headers: headers, body: dataReg);
  String resp = responseReg.body;

  var respbody = json.decode(resp);
  print(respbody["status"]);
  print(respbody);
  if (responseReg.statusCode == 200) {
    regNameData.clear();
    regEmailData.clear();
    regPhoneData.clear();
    regPassData.clear();
    if (respbody["status"] == "true") {
      print("Registered.....");
      Scaffold.of(context1).showSnackBar(snackBarRegisterManager);
       ftpClient.connect();
      print(_image.path);
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
            _image.delete();
      }
      Navigator.pop(context1);
    }
    if (respbody["status"] == "false") {
      print("Error");
      Scaffold.of(context1).showSnackBar(SnackBar(
        content: Text("Error in Registering as Manager...."),
      ));
      // Builder(builder: (context1) => Scaffold.of(context1).showSnackBar(snackBarRegister),);

    }
  }
}

void sendGuestData(
  BuildContext guestContext,
  TextEditingController _guestNameData,
  TextEditingController _guestEmailData,
  TextEditingController _guestPhoneData,
) async {
  String nameGuest = _guestNameData.text;
  String emailGuest = _guestEmailData.text;
  String phoneGuest = _guestPhoneData.text;
  print("$nameGuest,$emailGuest,$phoneGuest");
  String dataGuest =
      '{"phone": "$phoneGuest","name": "$nameGuest","email":"$emailGuest"}';
  var responseGuest =
      await http.post(guestLogin, headers: headers, body: dataGuest);
  String respGuest = responseGuest.body;

  var _respbodyGuest = json.decode(respGuest);

  setUser(_respbodyGuest, false);
  setTitle("guest");

  if (responseGuest.statusCode == 200) {
    _guestNameData.clear();
    _guestEmailData.clear();
    _guestPhoneData.clear();
    // print(respbodyGuest);

    if (_respbodyGuest["status"] == "true") {
      print("GUesst Dataa");
      Navigator.push(
          guestContext, MaterialPageRoute(builder: (context) => Dashboard()));
    }
    if (_respbodyGuest["status"] == "false") {
      print("Error");
      Scaffold.of(guestContext).showSnackBar(snackBarErrorGuest);
      // Builder(builder: (context1) => Scaffold.of(context1).showSnackBar(snackBarRegister),);

    }
  }
}
