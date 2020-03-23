import 'dart:async';
import 'package:email_validator/email_validator.dart';

String pattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp regExp = new RegExp(pattern);

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
      sink.addError("Enter a valid password");
    }
  });
}
