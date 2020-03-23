import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/allFiles.dart';

void loginCheck(BuildContext context, TextEditingController _nameContro,
    TextEditingController _passContro) async {
  String name = _nameContro.text;
  String pass = _passContro.text;
  String data = '{"email":"$name","password":"$pass"}';

  var response = await http.post(userLogin, headers: headers, body: data);
  print(response.body);
  String resp = response.body;

  var respbody = json.decode(resp);
  print(respbody["status"]);
  if (response.statusCode == 200) {
    if (respbody["status"] == "true") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else if (respbody["status"] == "false") {
      Scaffold.of(context).showSnackBar(snackBarLogin);

      print("Error is Dashboard moving......");
    }
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
    // regNameData.clear();
    // regEmailData.clear();
    // regPhoneData.clear();
    // regPassData.clear();
    if (respbody["status"] == "true") {
      print("Registered.....");
      Scaffold.of(context1).showSnackBar(snackBarRegister);
      
    }
    if (respbody["status"] == "false") {
      print("Error");
      Scaffold.of(context1).showSnackBar(snackBarError);
      // Builder(builder: (context1) => Scaffold.of(context1).showSnackBar(snackBarRegister),);
      

      
    }
  }
}
