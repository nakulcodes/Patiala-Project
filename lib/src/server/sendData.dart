import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_login_signup/allFiles.dart';

class LoginLoaderUser extends StatefulWidget {
  BuildContext context;
  String _nameContro;
  String _passContro;

  LoginLoaderUser(this.context, this._nameContro, this._passContro);

  @override
  _LoginLoaderUserState createState() => _LoginLoaderUserState();
}

class _LoginLoaderUserState extends State<LoginLoaderUser> {
  void loginCheck() async {
    print("Coming.........");
    String name = widget._nameContro;
    String pass = widget._passContro;
    String data = '{"email":"$name","password":"$pass"}';

    var response = await http.post(userLogin, headers: headers, body: data);
    print(response.body);
    String resp = response.body;

    var respbody = json.decode(resp);

    print(respbody["status"]);

    if (response.statusCode == 200) {
      if (respbody["status"] == "true") {
        setUser(respbody, true);

        print(respbody["token"]);
        setTitle("reg_user");

        headers["token"] = respbody["token"];

        // print(person.namee);

        Navigator.push(widget.context,
            MaterialPageRoute(builder: (context) => NavigationBar()));
      } else if (respbody["status"] == "false") {
        // print(person.namee);
        dialog(
            context,
            "Wrong Credentials!",
            Image.asset("assets/images/red2.png"),
            () => Navigator.popAndPushNamed(context, "loginPage"));

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
  String _nameContro;
  String _passContro;

  LoginLoaderManager(this.context, this._nameContro, this._passContro);
  @override
  _LoginLoaderManagerState createState() => _LoginLoaderManagerState();
}

class _LoginLoaderManagerState extends State<LoginLoaderManager> {
  void managerLoginCheck() async {
    print("Coming......... inside Manager Login Check");
    String name = widget._nameContro;
    String pass = widget._passContro;

    String data = '{"email":"$name","password":"$pass"}';
    print(data);

    var response = await http.post(managerLogin, headers: headers, body: data);
    print(response.body);
    String resp = response.body;

    var respbody = json.decode(resp);

    print(respbody["status"]);

    if (response.statusCode == 200) {
      if (respbody["status"] == "true") {
        setUser(respbody, true);
        setBank(respbody["bank_id"]);
        setMobileManager(respbody["phone"]);
        setBankLocation(respbody["location"]);
        setAvailHel(respbody["available_helmets"]);
        setTotalHel(respbody["total_helmets"]);
        setName(respbody["name"]);
        headers["token"] = respbody["token"];

        // print(person.namee);

        Navigator.push(widget.context,
            MaterialPageRoute(builder: (context) => ManagerDashboard()));

        // Navigator.pushReplacementNamed(context, )
      } else if (respbody["status"] == "false") {
        dialog(
            context,
            "Wrong Credentials!",
            Image.asset("assets/images/red2.png"),
            () => Navigator.popAndPushNamed(context, "loginPage"));

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


Future<Widget> dialog(
    BuildContext _context, String title, Widget image, Function ontapp) {
  return showDialog(
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Center(
              child: Text(
            "$title",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          content: Container(
            width: 200,
            height: 200,
            child: image,
          ),
          actions: [
            // InkWell(child: Text("Book"), onTap: ontapp),
            _button("Okay", Color(0xfffe9263), ontapp)
          ],
        );
      });
}

Widget _button(String title, Color col, Function onPressed) {
  return Container(
    width: 100,
    height: 40,
    decoration: BoxDecoration(
        color: col, borderRadius: BorderRadius.all(Radius.circular(5))),
    child: InkWell(
      onTap: onPressed,
      child: Center(
          child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      )),
    ),
  );
}



class Guest extends StatefulWidget {
  BuildContext guestContext;
  String nameGuest;
  String emailGuest;
  String phoneGuest;
  String addGuest;
  File _image;
  Guest(this.guestContext, this.nameGuest, this.emailGuest, this.phoneGuest,
      this.addGuest, this._image);
  @override
  _GuestState createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  void sendGuestData() async {
    print(widget.nameGuest);
    BuildContext _guestContext = widget.guestContext;
    String nameGuest = widget.nameGuest;
    String emailGuest = widget.emailGuest;
    String phoneGuest = widget.phoneGuest;
    String addGuest = widget.addGuest;
    File _image = widget._image;

    print("$nameGuest,$emailGuest,$phoneGuest");
    String dataGuest =
        '{"phone": "$phoneGuest","name": "$nameGuest","email":"$emailGuest","address":"$addGuest"}';
    var responseGuest =
        await http.post(guestLogin, headers: headers, body: dataGuest);
    String respGuest = responseGuest.body;

    var _respbodyGuest = json.decode(respGuest);

    setUser(_respbodyGuest, false);
    setTitle("guest");

    if (responseGuest.statusCode == 200) {
      if (_respbodyGuest["status"] == "true") {
        print("GUesst Dataa");
        headers["token"] = _respbodyGuest["token"];
        ftpClient.connect();
        print(_image.path);
        try {
          print("Tryingg");
          ftpClient.changeDirectory("/Images/Guests/");
          ftpClient.makeDirectory(emailGuest);
          ftpClient.changeDirectory(emailGuest);

          ftpClient.uploadFile(_image);
          // Duration(seconds: 4);
          // print(_image.path.split("/").last);
          // ftpClient.changeDirectory(emailReg);
          // ftpClient.rename(_image.path.split("/").last, emailReg);
        } finally {
          ftpClient.disconnect();
          _image.delete();
        }
        Navigator.push(_guestContext,
            MaterialPageRoute(builder: (context) => Dashboard()));
      }
      if (_respbodyGuest["status"] == "false") {
        print("Error");
        Scaffold.of(_guestContext).showSnackBar(snackBarErrorGuest);
        // Builder(builder: (context1) => Scaffold.of(context1).showSnackBar(snackBarRegister),);

      }
    }
  }

  @override
  void initState() {
    super.initState();
    sendGuestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorLoader5(),
    );
  }
}
