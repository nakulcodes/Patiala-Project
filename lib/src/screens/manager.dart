import 'package:flutter_login_signup/allFiles.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';

final TextEditingController _helmetNumber = TextEditingController();
final IO.Socket socket = IO.io('https://hlmt.herokuapp.com/', <String, dynamic>{
  'transports': ['websocket'],
});

List _bankData;

String totalHelmets;
String availHelmets;
bool dataRecieved = true;
bool helEntered;
bool noHistory;
String _name;
String _managerNumber;
String bankId;
String _locationName;
int check;
int _selectedRadio = 0;

var refreshKey = GlobalKey<RefreshIndicatorState>();

class ManagerDashboard extends StatefulWidget {
  @override
  _ManagerDashboardState createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  void _getBankData() async {
    var data1 = await http.post(
        "https://hlmt.herokuapp.com/api/managers/history",
        headers: headers,
        body: '{"bank_id":"$bankId"}');
    // print(data1.body);
    String data2 = data1.body;
    var data3 = json.decode(data2);
    // print(data3["transactions"]);
    if (data1.statusCode == 200) {
      if (data3["status"] == "true") {
        // joinRoom();
        _bankData = data3["transactions"];
        // print(_bankData.length);
        if (mounted)
          setState(() {
            // noHistory = false;
            check = 1;
          });
      } else if (data3["status"] == "false") {
        // joinRoom();
        // noHistory = null;
        if (mounted)
          setState(() {
            check = 0;
          });
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Server Error"),
      ));
    }
  }

  void _sendBookingData(
      int index, int status, String helmetNumber, BuildContext _context) async {
    _helmetNumber.clear();
    var transactionID = _bankData[index]["transaction_id"];
    // print(index);
    // print(status);
    // print(helmetNumber);
    // print(transactionID);
    var data1 = await http.post(
        "https://hlmt.herokuapp.com/api/transactions/approve",
        headers: headers,
        body:
            '{"transaction_id":$transactionID,"approved":$status,"helmet_no":$helmetNumber,"manager":$_managerNumber}');
    // print(data1.body);
    String data2 = data1.body;
    var data3 = json.decode(data2);
    print(_bankData.length);
    if (data1.statusCode == 200) {
      if (data3["status"] == "true") {
        if (status == 1) {
          int _no = int.parse(availHelmets);
          setAvailHel((_no - 1).toString());
          availHelmets = getAvailHel();
        }
        if (mounted)
          setState(() {
            _bankData.removeAt(index);
            if (status == 1) {
              availHelmets = getAvailHel();
            }
            if (_bankData.length == 0) {
              check = 0;
            }
          });
      } else if (data3["status"] == "false") {
        if (data3["desc"] == "helmet") {
          Scaffold.of(_context).showSnackBar(SnackBar(
            content: Text("Wrong Helmet Number"),
          ));
        } else {
          if (mounted)
            setState(() {
              _bankData.removeAt(index);
              if (_bankData == null) {
                noHistory = null;
              }
            });

          Scaffold.of(_context).showSnackBar(SnackBar(
            content: Text("Time Exceeded"),
          ));
        }
      }
    } else {
      Scaffold.of(_context).showSnackBar(SnackBar(
        content: Text("Server Error"),
      ));
    }
  }

  // List check;

  void join() {
    // print("Coming..");
    socket.emit('join', {"phone": _managerNumber});

    socket.on("incoming", (data) {
      // Map<String, dynamic> t = {"transactions": data};
      print(data);

      // print(t);
      // print(t);
      //   check = [data];
      if (check == 0) {
        _bankData = [data];
        if (mounted) {
          setState(() {
            check = 1;
            // noHistory = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _bankData.add(data);
          });
        }
      }
      //  print(check);
      //   print(check.length);

      // _bankData.add(data);

      // print(_bankData);
      // print(_bankData.length);
// setState(() {
//       if (noHistory != null) {
//         setState(() {
//           _bankData.add(t["transactions"]);
//         });
//       }
//       // else if (noHistory == null) {
//       //   print("Coming Here");

//       //     _bankData = [t];
//       //     noHistory = false;
//       //   }
//       });
      // print(_bankData);
    });
  }

  Future<Null> refreshList() async {
    // refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    // print("REFRESHING");
    _getBankData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _managerNumber = getManagerMobile();
    bankId = getBank();
    _name = getName();
    _locationName = getBankLocation();
    totalHelmets = getTotalHel();
    availHelmets = getAvailHel();

    socket.connect();
    // print("\n");
    socket.on("check", (data) {
      // print("Inside Socket Check");
      // print(data);
      while (data != true) {
        socket.connect();
      }
    });
    join();

    _getBankData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: RefreshIndicator(
          onRefresh: refreshList,
          key: refreshKey,
          child: Column(
            children: <Widget>[
              _top(),
              check == 0
                  ? Expanded(
                      child: Container(
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height - 144,
                        decoration: BoxDecoration(
                            color: Color(0xfffe9263),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "No Pending \nRequests",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  // )
                  : Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: ListView.builder(
                            // itemCount: 15,
                            itemCount: _bankData == null ? 0 : _bankData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                  child: Card(
                                child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.fromLTRB(
                                        5.0, 5.0, 5.0, 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    radius: 30,
                                                  ),
                                                  _bankData[index]["user"]
                                                              .length <
                                                          8
                                                      ? Text(
                                                          _bankData[index]
                                                              ["user"],
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                      : Text(
                                                          _bankData[index]
                                                              ["user"],
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ]),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                _rowText(
                                                    "Transaction Id : ",
                                                    _bankData[index]
                                                        ["transaction_id"]),
                                                _bankData[index][
                                                            "issue_datetime"] ==
                                                        null
                                                    ? _rowText(
                                                        "Request Time : ",
                                                        _bankData[index]
                                                            ["query_datetime"])
                                                    : _rowText(
                                                        "Time Picked : ",
                                                        _bankData[index]
                                                            ["issue_datetime"]),
                                              ],
                                            ),
                                          ],
                                        ),
                                        _bankData[index]["issue_datetime"] ==
                                                null
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  _button("Accept", () {
                                                    print("Accept Pressed");
                                                    _dialog(context, index);
                                                    // setState(() {
                                                    //   helmetPicked = true;
                                                    // });
                                                  }, Colors.green[600]),
                                                  _button("Decline", () {
                                                    print("Decline Pressed");
                                                    _sendBookingData(index, 0,
                                                        "null", context);
                                                  }, Colors.red),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  _helmetReturnButton(
                                                    "Helmet\nRecieved",
                                                    Colors.yellow,
                                                    () async {
                                                      print(
                                                          "Helmet Recived Pressed");
                                                      var completeData =
                                                          await http.post(
                                                              completeTransacion,
                                                              headers: headers,
                                                              body:
                                                                  json.encode({
                                                                "transaction_id":
                                                                    int.parse(_bankData[
                                                                            index]
                                                                        [
                                                                        "transaction_id"]),
                                                                "manager":
                                                                    _managerNumber,
                                                                "foundfaulty":
                                                                    _selectedRadio
                                                              }));

                                                      var completeJson = json
                                                          .decode(completeData
                                                              .body);
                                                      if (completeJson[
                                                                  "status"] ==
                                                              "true" &&
                                                          completeData
                                                                  .statusCode ==
                                                              200) {
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Transaction Completed"),
                                                        ));
                                                        int _no = int.parse(
                                                            availHelmets);
                                                        setAvailHel((_no + 1)
                                                            .toString());
                                                        setState(() {
                                                          availHelmets =
                                                              getAvailHel();
                                                          if (_bankData
                                                                  .length ==
                                                              1) {
                                                            check = 0;
                                                          }
                                                          _bankData
                                                              .removeAt(index);
                                                        });
                                                      } else {
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Server Error...."),
                                                        ));
                                                      }
                                                      // socketIO.sendMessage(
                                                      //     "complete",
                                                      // json.encode({
                                                      //   "body": {
                                                      //     "transaction_id":
                                                      //         int.parse(_bankData[
                                                      //                 index][
                                                      //             "transaction_id"]),
                                                      //     "manager": "8146992621",
                                                      //   }
                                                      // }));
                                                      //     http.post(completeTransacion,
                                                      //         headers: headers,
                                                      //         body:
                                                      //             // "body":{"transaction_id":  int.parse(_bankData[index]["transaction_id"]),"manager": managerMobile});
                                                      //  );
                                                    },
                                                  ),
                                                  Container(
                                                      height: 17,
                                                      child: Row(
                                                          children: <Widget>[
                                                            Radio(
                                                              value: 0,
                                                              groupValue:
                                                                  _selectedRadio,
                                                              onChanged: (val) {
                                                                print(val);
                                                                setSelectedRadio(
                                                                    val);
                                                              },
                                                            ),
                                                            Text("Okay")
                                                          ])),
                                                  Container(
                                                      height: 17,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: <Widget>[
                                                          Radio(
                                                            value: 1,
                                                            groupValue:
                                                                _selectedRadio,
                                                            onChanged: (val) {
                                                              print(val);
                                                              setSelectedRadio(
                                                                  val);
                                                            },
                                                          ),
                                                          Text("Damaged"),
                                                        ],
                                                      )),
                                                ],
                                              )
                                      ],
                                    )),
                              ));
                            }),
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height - 144,
                        // height: MediaQuery.of(context).size.height / 10 * 8 -18,
                        decoration: BoxDecoration(
                            color: Color(0xfffe9263),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                      ),
                    ),

              // )
              // : Container(
              //     width: double.infinity,
              //     height: MediaQuery.of(context).size.height - 144,
              //     decoration: BoxDecoration(
              //         color: Color(0xfffe9263),
              //         borderRadius: BorderRadius.only(
              //             topRight: Radius.circular(10),
              //             topLeft: Radius.circular(10))),
              //     child: Center(
              //         child: Text(
              //       "No Pending \nRequests",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 30,
              //         fontWeight: FontWeight.bold,
              //       ),
              //       textAlign: TextAlign.center,
              //     )),
              // ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _button(String title, Function onPressed, Color col) {
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
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  Widget _helmetReturnButton(String title, Color col, Function onPressed) {
    return Container(
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
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  Widget _top() {
    return Container(
      // padding: EdgeInsets.all(1.0),
      height: MediaQuery.of(context).size.height / 10 * 2,
      width: double.infinity,
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
          Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.fromLTRB(5, 10, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                // height: MediaQuery.of(context).size.height / 10 * 2,
                child: _name.length < 6
                    ? Text(
                        "Hi! " + _name,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      )
                    : _name.length <= 10
                        ? Text(
                            "Hi! " + _name,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "Hi! " + _name.substring(0, 10) + "..",
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
              ),
              Row(
                children: <Widget>[
                  Text("Bank\nAlloted : ", textAlign: TextAlign.start),
                  Text(
                    _locationName.length < 13
                        ? "$_locationName"
                        : _locationName.substring(0, 13) + "..",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 5),
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Total Helmets : ",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "$totalHelmets",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Available Helmets : ",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "$availHelmets",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: ButtonTheme(
                      child: RaisedButton(
                        color: Color(0xfffe9263),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onPressed: () {
                          print("Logout Pressed");
                          // _locationName.length;
                          _helmetNumber.clear();
                          // socketIO.unSubscribesAll();
                          // socketIO.disconnect();
                          socket.disconnect();
                          socket.close();
                          check = 0;
                          //                     Navigator.pushAndRemoveUntil(
                          // context,
                          // PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                          //     Animation secondaryAnimation) {
                          //   return LoginPage();
                          // }, transitionsBuilder: (BuildContext context, Animation<double> animation,
                          //     Animation<double> secondaryAnimation, Widget child) {
                          //   return new SlideTransition(
                          //     position: new Tween<Offset>(
                          //       begin: const Offset(1.0, 0.0),
                          //       end: Offset.zero,
                          //     ).animate(animation),
                          //     child: child,
                          //   );
                          // }),
                          // (Route route) => false);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage(),
                              ),
                              (route) => false);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _rowText(String text, String data) {
    return Row(
      children: <Widget>[
        Text(text),
        Container(
          width: 70,
          child: Text(
            data,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Future<Widget> _dialog(BuildContext _context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: Center(child: Text("Enter Helmet Number")),
            content: TextField(
              controller: _helmetNumber,
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
            actions: [
              InkWell(
                  child: _helmetReturnButton("Book", Colors.green[600], () {
                print(_helmetNumber.text.toString());

                _sendBookingData(index, 1, _helmetNumber.text, _context);
                Navigator.pop(_context);
              })),
            ],
          );
        });
  }

  void setSelectedRadio(int val) {
    setState(() {
      _selectedRadio = val;
    });
  }
}
