import 'package:flutter_login_signup/allFiles.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

final TextEditingController _helmetNumber = TextEditingController();
final IO.Socket socket = IO.io('https://hlmt.herokuapp.com/', <String, dynamic>{
  'transports': ['websocket'],
});

class ManagerDashboard extends StatefulWidget {
  @override
  _ManagerDashboardState createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  List _bankData;
  // SocketIO socketIO;
  String totalHelmets;
  String availHelmets;
  bool dataRecieved = true;
  bool helEntered;
  bool noHistory;
  String _name;
  String _managerNumber;
  String bankId;
  String _locationName;
  SocketIO socketIO = SocketIOManager().createSocketIO(
    'https://hlmt.herokuapp.com',
    '/',
  );
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void _getBankData() async {
    var data1 = await http.post(
        "https://hlmt.herokuapp.com/api/managers/history",
        headers: headers,
        body: '{"bank_id":"$bankId"}');
    print(data1.body);
    String data2 = data1.body;
    var data3 = json.decode(data2);
    print(data3["transactions"]);
    if (data1.statusCode == 200) {
      if (data3["status"] == "true") {
        // joinRoom();
        _bankData = data3["transactions"];
        print(_bankData.length);
        setState(() {
          noHistory = false;
        });
      } else if (data3["status"] == "false") {
        // joinRoom();
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
    print(index);
    print(status);
    print(helmetNumber);
    print(transactionID);
    var data1 = await http.post(
        "https://hlmt.herokuapp.com/api/transactions/approve",
        headers: headers,
        body:
            '{"transaction_id":$transactionID,"approved":$status,"helmet_no":$helmetNumber,"manager":$_managerNumber}');
    print(data1.body);
    String data2 = data1.body;
    var data3 = json.decode(data2);

    if (data1.statusCode == 200) {
      if (data3["status"] == "true") {
        setState(() {
          _bankData.removeAt(index);
        });
      } else if (data3["status"] == "false") {
        if (data3["desc"] == "helmet") {
          Scaffold.of(_context).showSnackBar(SnackBar(
            content: Text("Wrong Helmet Number"),
          ));
        } else {
          setState(() {
            _bankData.removeAt(index);
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

  Future join() async {
    print("Coming..");
    socket.emit('join', {"phone": _managerNumber});

    socket.on("incoming", (data) {
      Map<String, dynamic> t = {"transactions": data};

      if (noHistory != null) {
        setState(() {
          _bankData.add(t["transactions"]);
        });
      } else if (noHistory == null) {
        setState(() {
          _bankData = [t["transactions"]];
          noHistory = false;
        });
      }
      // print(_bankData);
    });
  }

  Future<Null> refreshList() async {
    // refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    print("REFRESHING");
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
    print("\n");
    socket.on("check", (data) {
      print("Inside Socket Check");
      print(data);
      while (data != true) {
        socket.connect();
      }
    });
    join();

    _getBankData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: Column(
          children: <Widget>[
            _top(),
            noHistory == null
                ? Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 144,
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
                  )
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
                                                  MainAxisAlignment.spaceEvenly,
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
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ]),
                                          SizedBox(
                                            width: 4,
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
                                              _bankData[index]
                                                          ["issue_datetime"] ==
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
                                      _bankData[index]["issue_datetime"] == null
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
                                          : _helmetReturnButton(
                                              "Helmet\nRecieved",
                                              Colors.yellow,
                                              () async {
                                                print("Helmet Recived Pressed");
                                                var completeData = await http
                                                    .post(completeTransacion,
                                                        headers: headers,
                                                        body: json.encode({
                                                          "transaction_id": int
                                                              .parse(_bankData[
                                                                      index][
                                                                  "transaction_id"]),
                                                          "manager":
                                                              _managerNumber
                                                        }));

                                                var completeJson = json
                                                    .decode(completeData.body);
                                                if (completeJson["status"] ==
                                                        "true" &&
                                                    completeData.statusCode ==
                                                        200) {
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Transaction Completed"),
                                                  ));
                                                  setState(() {
                                                    _bankData.removeAt(index);
                                                  });
                                                } else {
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
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
    ));
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
      width: 100,
      height: 50,
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
          padding: EdgeInsets.fromLTRB(5, 10, 0, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _name.length < 9
                    ? "Hi! " + _name
                    : "Hi! " + _name.substring(0, 9),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                          _locationName.length;
                          _helmetNumber.clear();
                          // socketIO.unSubscribesAll();
                          // socketIO.disconnect();
                          socket.disconnect();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
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
}
