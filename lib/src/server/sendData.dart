import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/allFiles.dart';

void loginCheck(BuildContext context, TextEditingController nameContro,
    TextEditingController passContro) async {
  String name = nameContro.text;
  String pass = passContro.text;
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

      print("Comin......");

      print("Error is Dashboard moving......");
    }
  }
}

void registerUser(BuildContext context) {
  Scaffold.of(context).showSnackBar(snackBarRegister);
}
