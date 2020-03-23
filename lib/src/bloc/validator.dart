import 'dart:async';
import 'package:email_validator/email_validator.dart';

String pattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
String numPatttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
RegExp regExp = new RegExp(pattern);
RegExp regExpNum = new RegExp(numPatttern);

mixin Validators {
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (EmailValidator.validate(email)) {
      sink.add(email);
    } else if (EmailValidator.validate(email) || email.contains(" ")) {
      sink.add(email);
    } else {
      sink.addError("Email is not valid");
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (regExp.hasMatch(password) == true) {
      sink.add(password);
      // print(password);

    } else {
      sink.addError(
          "Enter a valid password with Uppercase,Lowercase\nSpecial Character & number");
    }
  });

  var numberValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (number, sink) {
    if (regExpNum.hasMatch(number)) {
      sink.add(number);
    } else {
      sink.addError("Number is not valid");
    }
  });
}
