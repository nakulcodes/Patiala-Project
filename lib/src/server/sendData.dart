import 'package:http/http.dart' as http;

import 'package:flutter_login_signup/allFiles.dart';

class LoginLoader extends StatefulWidget {
  BuildContext context;
  TextEditingController _nameContro;
  TextEditingController _passContro;

  LoginLoader(this.context, this._nameContro, this._passContro);

  @override
  _LoginLoaderState createState() => _LoginLoaderState();
}

class _LoginLoaderState extends State<LoginLoader> {
  void loginCheck() async {

    print("Coming.........");
    String name = widget._nameContro.text;
    String pass = widget._passContro.text;
    String data = '{"email":"$name","password":"$pass"}';

    var response = await http.post(userLogin, headers: headers, body: data);
    print(response.body);
    String resp = response.body;

    var respbody = json.decode(resp);

    print(respbody["status"]);
    setUser(respbody, true);

    if (response.statusCode == 200) {
      if (respbody["status"] == "true") {
        widget._nameContro.clear();
        widget._passContro.clear();

        // print(person.namee);

        Navigator.push(
            widget.context,
            MaterialPageRoute(
                builder: (context) => Dashboard(
                      
                    )));
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

void registerUser(
    BuildContext context1,
    TextEditingController regNameData,
    TextEditingController regEmailData,
    TextEditingController regPhoneData,
    TextEditingController regPassData) async {
  // Scaffold.of(context).showSnackBar(snackBarRegister);
  String nameReg = regNameData.text;
  String emailReg = regEmailData.text;
  String phoneReg = regPhoneData.text;
  String passReg = regPassData.text;

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
      Navigator.pop(context1);
    }
    if (respbody["status"] == "false") {
      print("Error");
      Scaffold.of(context1).showSnackBar(snackBarErrorReg);
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

  var respbodyGuest = json.decode(respGuest);

  setUser(respbodyGuest, false);

  if (responseGuest.statusCode == 200) {
    _guestNameData.clear();
    _guestEmailData.clear();
    _guestPhoneData.clear();
    print(respbodyGuest);

    if (respbodyGuest["status"] == "true") {
      print("Registered.....");
      // Navigator.push(
      //     guestContext, MaterialPageRoute(builder: (context) => Dashboard()));
    }
    if (respbodyGuest["status"] == "false") {
      print("Error");
      Scaffold.of(guestContext).showSnackBar(snackBarErrorGuest);
      // Builder(builder: (context1) => Scaffold.of(context1).showSnackBar(snackBarRegister),);

    }
  }
}
