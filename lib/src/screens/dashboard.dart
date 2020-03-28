import 'package:flutter_login_signup/allFiles.dart';
import 'package:flutter_login_signup/check.dart';
import 'package:flutter_login_signup/src/screens/storedata.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  int q;
  // BuildContext context;
  // TextEditingController _nameContro;
  // TextEditingController _passContro;
  // Dashboard();
  _DashboardState createState() => _DashboardState();
  // bottom: bottom, perDash: perDash, count: count);
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
  bool bar;
  bool check1 = false;
  int r = 0;
  int q;

  @override
  void initState() {
    bar = isBar();
    super.initState();
    // this.loginCheck();

    print("$q this is q..........");
    print("Cominggggggggggggggggggggggggggggggggggggggggggggg");
    this.getBankdata();
    this.getUserData();
    setMobile(number);

    // if (q == 0) {
    //   print(nameUser);
    //   setState(() {
    //     check1 = true;
    //   });
    // }
  }

  // Future loginCheck() async {
  //   // AccountPerson acc = new AccountPerson();
  //   print("Coming.........");
  //   String name = widget._nameContro.text;
  //   String pass = widget._passContro.text;
  //   String data = '{"email":"$name","password":"$pass"}';

  //   var response = await http.post(userLogin, headers: headers, body: data);
  //   print(response.body);
  //   String resp = response.body;

  //   var respbody = json.decode(resp);

  //   print(respbody["status"]);

  //   setUser(respbody, true);
  //   if (response.statusCode == 200) {
  //     if (respbody["status"] == "true") {
  //       widget._nameContro.clear();
  //       widget._passContro.clear();
  //       print("..............................");

  //       // print(person.namee);

  //       // Navigator.push(
  //       //     widget.context,
  //       //     MaterialPageRoute(
  //       //         builder: (context) => Dashboard(
  //       //               q: 1,
  //       //             )));
  //     } else if (respbody["status"] == "false") {
  //       // print(person.namee);
  //       Navigator.pop(context);
  //       // Scaffold.of(widget.context).showSnackBar(snackBarLogin);

  //       print("Error is Dashboard moving......");
  //     }
  //   }
  // }

  String getUserData() {
    var q = getUser();
    // data = q["banks"];
    nameUser = q["name"];
    number = q["phone"];

    // var _responseData = getBankdataa();

    // availUser = q["available_helmets"];
    // totalUser = q["total_helmets"];
    // hel = q["helmets"];
    // check = data.length.toString();

    return "Working.....";
  }

  void getBankdata() async {
    var _response = await http.get(userBank, headers: headers);
    print(_response.statusCode);
    String _responseBody = _response.body;
    var _responseData = json.decode(_responseBody);

    if (_response.statusCode == 200) {
      print("Banks are Working......");
      // return _responseData;
      availUser = _responseData["available_helmets"];
      totalUser = _responseData["total_helmets"];
      data = _responseData["banks"];
      setState(() {
        check1 = true;
      });
    }
  }

  showAlertDialog(BuildContext context, String title) {
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
      backgroundColor: Colors.white,
      title: Text("Booking Status"),
      content: Text(title),
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
    var _body1 = '{"bank":"$data","type":"reg_user","phone":"$number"}';
    var _helResp = await http.post(bookHelmet, headers: headers, body: _body1);
    print(_helResp);
    String _helRepStr = _helResp.body;

    var _helMap = json.decode(_helRepStr);
    print(_helMap);
    if (_helResp.statusCode == 200) {
      if (_helMap["status"] == "true") {
        print("It's Here");
        // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Helmet Booked")));
        showAlertDialog(context, "Your Helmet is Booked.");
      } else if (_helMap["status"] == "false") {
        print("It's Here Booked Helmet");
        showAlertDialog(context, "You already have a helmet is possesion.");
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
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _topHome(),
                        SizedBox(
                          width: 12,
                        ),
                        _listBuild(),
                        _avail(context),
                      ],
                    ),
                  ),
                ),
              )
            : ColorLoader5());
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  //!    "Hi! $name",
                  "Hi! $nameUser",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  width: 130.0,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 30.0,
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 8 - 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
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
                          "   Total\nHelmets",
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
                        "Alloted\nHelmet",
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
      decoration: BoxDecoration(
        color: Color(0xfffe9263),
      ),
      height: MediaQuery.of(context).size.height / 1.9,
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
                        Text(data[index]["helmets"],style: TextStyle(fontSize: 25),),
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

  // Widget _bottomNavBar() {
  //   return CurvedNavigationBar(
  //     height: 50,
  //     backgroundColor: Color(0xfffe9263),
  //     items: <Widget>[
  //       Icon(Icons.home, size: 30),
  //       Icon(Icons.history, size: 30),
  //       Icon(Icons.account_circle, size: 30),
  //     ],
  //     onTap: (index) {
  //       //Handle button tap
  //       print(index);
  //       if (index == 1) {
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => History(),
  //             ));
  //       }
  //       if (index == 2) {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => Account(),
  //             ));
  //       }
  //     },
  //   );
  // }

  // Widget _logout() {
  //   return Container(
  //       height: 50,
  //       // margin: EdgeInsets.symmetric(vertical: 20),
  //       child: ButtonTheme(
  //         minWidth: MediaQuery.of(context).size.width - 20.0,
  //         height: 100.0,
  //         child: RaisedButton(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(8.0),
  //             // side: BorderSide(color: Colors.red)
  //           ),
  //           color: Colors.white,
  //           onPressed: () => Navigator.pop(context),
  //           child: Text('Logout',
  //               style: TextStyle(
  //                   color: Color(0xfffe9263),
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.w400)),
  //         ),
  //       ));
  // }
}
