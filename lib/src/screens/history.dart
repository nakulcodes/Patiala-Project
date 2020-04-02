import 'package:flutter_login_signup/allFiles.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String _mobile;
  List _toShow;
  bool _check = false;
  bool _check1 = true;
  // List noData = [
  //   {"data": "No History"}
  // ];

  void getHistory() async {
    
    print(headers);
    var data = await http.post(userHistory,
        headers: headers, body: '{"phone": "$_mobile"}');
    String dataBody = data.body;
    var body1 = json.decode(dataBody);
    print("\n\n\n\n\n\n\n\n\n");
    print(body1);
    if (data.statusCode == 200) {
      if (body1["status"] == "true") {
        print(body1);
        _toShow = body1["transactions"];
        if (mounted)
          setState(() {
            _check = true;
            _toShow = body1["transactions"];
          });
      } else {
        if (mounted)
          setState(() {
            print(body1);
            // _toShow = noData;
            _check = true;
            _check1 = false;
          });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _mobile = getMobile();
    getHistory();
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffe9263),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
              width: MediaQuery.of(context).size.width,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Text(
                "History!",
                style: TextStyle(color: Colors.black, fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ),
            _check
                ? Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    height: MediaQuery.of(context).size.height - 150,
                    // margin: EdgeInsets.only(top: 10),

                    child: _check1
                        ? ListView.builder(
                            // itemCount: 15,
                            itemCount:
                                _toShow.length == null ? 0 : _toShow.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                  child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _toShow[index]["location"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          _toShow[index]["msg"] == "Completed"
                                              ? Row(
                                                  children: <Widget>[
                                                    Text('Return Time: '),
                                                    Text(
                                                      _toShow[index]
                                                          ["return_datetime"],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              : _toShow[index]["msg"] ==
                                                      "In progress"
                                                  ? Row(
                                                      children: <Widget>[
                                                        Text('Pick Time: '),
                                                        _toShow[index][
                                                                    "issue_datetime"] ==
                                                                "null"
                                                            ? Text(
                                                                "Not Approved",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                _toShow[index][
                                                                    "issue_datetime"],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                      ],
                                                    )
                                                  : Text("Request Declined")
                                        ],
                                      ),
                                      Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(_toShow[index]["msg"]),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            _toShow[index]["msg"] == "Declined"
                                                ? Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle),
                                                  )
                                                : _toShow[index]["msg"] ==
                                                        "Completed"
                                                    ? Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                shape: BoxShape
                                                                    .circle),
                                                      )
                                                    : Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .yellow,
                                                                shape: BoxShape
                                                                    .circle),
                                                      )
                                          ])
                                    ],
                                  ),
                                ),
                              ));
                            })
                        : Center(
                            child: Text(
                            "No History.\nMake your First Booking",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )))
                : Container(
                    height: MediaQuery.of(context).size.height - 150,
                    child: Center(child: ColorLoader5())),
          ],
        ),
      ),
      // : ColorLoader5(),
    );
  }
}
