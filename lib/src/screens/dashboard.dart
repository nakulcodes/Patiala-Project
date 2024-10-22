import 'package:flutter_login_signup/allFiles.dart';
import 'package:flutter_login_signup/check.dart';
import 'package:flutter_login_signup/src/screens/storedata.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  int q;

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  _DashboardState();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List data;
  List hel;
  String nameUser;
  String availUser;
  String totalUser;
  String check;
  String number;
  String email;
  // String title;
  bool bar;
  bool check1 = false;
  int r = 0;
  int q;

  @override
  void initState() {
    bar = isBar();
    super.initState();
    // title = getTitle();

    print("$q this is q..........");
    print("Cominggggggggggggggggggggggggggggggggggggggggggggg");
    this.getBankdata();
    this.getUserData();
    // print(token);
    setMobile(number);
  }

  String getUserData() {
    var q = getUser();

    nameUser = q["name"];
    number = q["phone"];
    email = q["email"];

    return "Working.....";
  }

  void getBankdata() async {
    var _response = await http.get(userBank, headers: headers);
    print(_response.statusCode);
    String _responseBody = _response.body;
    var _responseData = json.decode(_responseBody);

    if (_response.statusCode == 200) {
      print("Banks are Working......");

      availUser = _responseData["available_helmets"];
      totalUser = _responseData["total_helmets"];
      data = _responseData["banks"];
      if (mounted)
        setState(() {
          check1 = true;
        });
    }
  }

  showAlertDialog(BuildContext context, String title, String title2,
      {double height}) {
    // String title;
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: Colors.white,
      title: Text(
        "Booking Status",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      content: Container(
        height: height == null ? 83.0 : height,
        width: 83,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title2,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void bookHelmetData(String data, BuildContext context) async {
    print("$data is inside book helmet");
    print("$number");
    var _body1 = '{"bank":"$data","type":"$title","phone":"$number"}';
    print(headers);
    print(_body1);
    var _helResp = await http.post(bookHelmet, headers: headers, body: _body1);
    print(_helResp);
    String _helRepStr = _helResp.body;

    var _helMap = json.decode(_helRepStr);
    print(_helMap);
    if (_helResp.statusCode == 200) {
      if (_helMap["status"] == "true") {
        print("It's Here");
        // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Helmet Booked")));
        showAlertDialog(context, "Your Helmet is Booked.",
            "You have 5 minutes to pick your helmets else request will be cancelled");
      } else if (_helMap["status"] == "false") {
        print("It's Here Booked Helmet");
        if (_helMap["desc"] == "requests exceeded") {
          var _num = _helMap["count"];
          showAlertDialog(
              context, 'You already have $_num pending requests.', "",
              height: 62.0);
        } else {
          showAlertDialog(
              context, "You already have a helmet is possesion.", "");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: check1
            ? WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: Color(0xfffe9263),
                  // backgroundColor: Colors.white,
                  // bottomNavigationBar: bar ? _bottomNavBar() : null,
                  body: Column(
                    children: <Widget>[
                      _topHome(),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      _listBuild(),
                      SizedBox(
                        height: 10,
                      ),
                      _avail(context),
                    ],
                  ),
                ),
              )
            : ColorLoader5());
  }

  Widget dia(String title, var _data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(title + " : "),
        Text(_data,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Future<Widget> _dialog(BuildContext _context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title:
                // Center(
                //     child:
                Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Your Account",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        dia("Name", nameUser),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        dia("Mobile", number),
                      ],
                    ),
                  ],
                )

                // dia("Email","nakulgarg2000@gmail.com"),
              ],
              // ),
            ),
            actions: [
              InkWell(
                  child: _logout("Logout", Color(0xfffe9263), () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage(),
                    ),
                    (route) => false);
              })),
            ],
          );
        });
  }

  Widget _logout(String title, Color col, Function onPressed) {
    return Center(
      child: Container(
        width: 120,
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
      ),
    );
  }

  Widget _topHome() {
    return Container(
      padding: EdgeInsets.all(10.0),
      // margin: EdgeInsets.fromLTRB(5, 10, 10,0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 8 - 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  //!    "Hi! $name",
                  nameUser.length < 13
                      ? "Hi! $nameUser"
                      : "Hi! " + nameUser.substring(0, 13) + "..",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  textAlign: TextAlign.left,
                ),
                // SizedBox(
                //   width: 130.0,
                // ),
                CircleAvatar(
                  backgroundColor: Color(0xfffe9263),
                  // backgroundImage: Icon()

                  radius: 30.0,
                  child: GestureDetector(
                    onTap: () {
                      _dialog(context);
                    },
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(100.0),
                      child: Image.network(
                        title == "guest"
                            ? fetchImage + "$email&Guests&" + headers["token"]
                            : fetchImage + "$email&User&" + headers["token"],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 8 - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  // height:60,
                  child: Column(
                    children: <Widget>[
                      Text(
                        //!    "Hi! $name",
                        "$totalUser",
                        // userDetails['phone'],
                        style:
                            TextStyle(color: Color(0xfffe9263), fontSize: 30),
                      ),
                      Center(
                        child: Text(
                          "Total\nHelmets",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        //!    "Hi! $name",
                        "$availUser",
                        // "q",
                        style:
                            TextStyle(color: Color(0xfffe9263), fontSize: 30),
                      ),
                      Text(
                        "Helmet\nAvailable",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }

  Widget _listBuild() {
    return Container(
      margin:
          title == "guest" ? EdgeInsets.only(top: 8) : EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Color(0xfffe9263),
      ),
      height: title == "guest"
          ? MediaQuery.of(context).size.height / 1.73
          : MediaQuery.of(context).size.height / 2.0,
      child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          padding: EdgeInsets.all(5),
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
                child: Card(
              color:
                  returnIndex(r, index) ? (Color(0xfffeb89a)) : (Colors.white),
              child: InkWell(
                onTap: () {
                  print(index);
                  bool i = setIndex(index);
                  print("\n\n\n\n\n");
                  print(i);
                  setState(() {
                    print(data[index]);

                    if (i == true) {
                      r++;
                      print(r);
                    }
                    if (i == false) {
                      r = 0;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data[index]["location"],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ]),
                      Row(children: <Widget>[
                        Text(
                          data[index]["helmets"],
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        int.parse(data[index]["helmets"]) > 12
                            ? Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                              )
                            : int.parse(data[index]["helmets"]) > 6
                                ? Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        shape: BoxShape.circle),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  )
                      ])
                    ],
                  ),
                ),
              ),
            ));
          }),
      // height: MediaQuery.of(context).size.height / 2 - 100,
    );
  }

  Widget _avail(BuildContext context) {
    return Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width - 20.0,
          height: 100.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              // side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            onPressed: r != 0
                ? () {
                    String _id1 = data[getIndex()]["bank_id"];
                    print(_id1);
                    bookHelmetData(_id1, context);

                    setState(() {
                      r = 0;
                    });
                  }
                : null,
            child: Text('Book Helmet',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ),
        ));
  }
}
