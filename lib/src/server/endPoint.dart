//End points...
import 'package:flutter_login_signup/allFiles.dart';
import 'dart:core';
import 'package:ftpclient/ftpclient.dart';

final String userLogin = "https://hlmt.herokuapp.com/api/users/login";
final String userRegister = "https://hlmt.herokuapp.com/api/users/register";
final String userHistory = "https://hlmt.herokuapp.com/api/users/history";
final String userBank = "https://hlmt.herokuapp.com/api/users/banks";
final String guestLogin = "https://hlmt.herokuapp.com/api/users/guest";
final String managerLogin = "https://hlmt.herokuapp.com/api/managers/login";
final String managerRegister =
    "https://hlmt.herokuapp.com/api/managers/register";
final String bookHelmet = "https://hlmt.herokuapp.com/api/transactions/add";
final String completeTransacion =
    "https://hlmt.herokuapp.com/api/transactions/complete";

//Headerss....
Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

FTPClient ftpClient = FTPClient('ftp.patialafoundation.org',
    user: 'helmet-images@patialafoundation.org', pass: 'patiala_foundation');
