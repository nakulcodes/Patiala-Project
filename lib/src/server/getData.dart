import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/allFiles.dart';

Map<String,dynamic> _q;


Map<String,dynamic>getBankdataa(){
  return _q;

}

//  void getBankdata() async {
//     var _response = await http.get(userBank, headers: headers);
//     print(_response.statusCode);
//     String _responseBody = _response.body;
//     var _responseData = json.decode(_responseBody);

//     if (_response.statusCode == 200) {
//       print("Banks are Working......");
//       print(_responseData);
      // availUser = _responseData["available_helmets"];
      // totalUser = _responseData["total_helmets"];
      // data = _responseData["banks"];
//       // check1 = true;
//       setState(() {
//         check1 = true;
//       });
//       print(availUser);
//       print(totalUser);
//     }
//   }
