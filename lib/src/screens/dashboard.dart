import 'package:flutter_login_signup/allFiles.dart';

class Dashboard extends StatefulWidget {
  bool bottom;
  AccountPerson perDash;
  int count;
  Dashboard({this.bottom, this.perDash, this.count});
  @override
  _DashboardState createState() => _DashboardState();
  // bottom: bottom, perDash: perDash, count: count);
}

class _DashboardState extends State<Dashboard> {
  // get name => perDash.nameGet;
  // get availHel => perDash.availHelmetNo;
  // get totHel => perDash.availHelmetNo; if(name == null)

  // q = name;

  // @override
  // void initState() {
  //   super.initState();
  //   // if (count == 0) {
  //   //   String name = perDash.nameGet;
  //   //   q = name;
  //   // }

  //   // print(name);

  //   print(perDash.nameGet);
  //   print(perDash.availHelmetNo);
  //   print(perDash.totalHelmetNo);
  // }

  Widget _avail() {
    return Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width - 20.0,
          height: 100.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              // side: BorderSide(color: Colors.red)
            ),
            color: Colors.white,
            onPressed: () => print("Name"),
            // snapshot.hasData

            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Dashboard()));
            // print(snapshot.hasData);
            // snapshot.hasData ? () {changeThePage(context);} : null;
            // ? () => changeThePage(context)
            // : null,
            child: Text('Check Availability',
                style: TextStyle(
                    color: Color(0xfffe9263),
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
          ),
        ));
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffe9263),
        // backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          backgroundColor: Color(0xfffe9263),
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.history, size: 30),
            Icon(Icons.account_circle, size: 30),
          ],
          onTap: (index) {
            //Handle button tap
            print(index);
            if (index == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => History(),
                  ));
            }
            if (index == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Account(),
                  ));
            }
          },
        ),

        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                // margin: EdgeInsets.fromLTRB(5, 10, 10,0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
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
                            "H",
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
                            "H",
                                  style: TextStyle(
                                      color: Color(0xfffe9263), fontSize: 30),
                                ),
                                Center(
                                  child: Text(
                                    "   Total\nHelmets",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
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
                            "H",
                                  style: TextStyle(
                                      color: Color(0xfffe9263), fontSize: 30),
                                ),
                                Text(
                                  "Alloted\nHelmet",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
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
                    // Container(
                    //   height: 50,
                    //   margin: EdgeInsets.symmetric(vertical: 20),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(10)),
                    //   ),
                    //   child: ButtonTheme(
                    //     // minWidth: MediaQuery.of(context).size.width,
                    //     minWidth: 350.0,
                    //     height: 100.0,
                    //     child: RaisedButton(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: new BorderRadius.circular(8.0),
                    //       ),
                    //       color: Color(0xfffe9263),
                    //       onPressed: () => print("book helmet"),
                    //       child: Text('Book Your Helmet',
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w400)),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                          color: Colors.white,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ButtonTheme(
                                  // padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                  minWidth: double.infinity,
                                  child: RaisedButton(
                                    onPressed: () => print("object"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                // height: MediaQuery.of(context).size.height / 2 - 100,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              _avail(),
            ],
          ),
        ),
      ),
    );
  }
  //State class
  // int _page = 0;
  // GlobalKey _bottomNavigationKey = GlobalKey();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(

  //       bottomNavigationBar: CurvedNavigationBar(
  //         height: 50,
  //         key: _bottomNavigationKey,
  //         items: <Widget>[
  //           Icon(Icons.home, size: 30),
  //           Icon(Icons.history, size: 30),
  //           Icon(Icons.account_circle, size: 30),
  //         ],
  //         onTap: (index) {
  //           setState(() {
  //             _page = index;
  //           });
  //         },
  //       ),
  //       body: Container(
  //         color: Colors.blueAccent,
  //         child: Center(
  //           child: Column(
  //             children: <Widget>[
  //               Container(child: Text(_page.toString(), textScaleFactor: 10.0)),
  //               RaisedButton(
  //                 child: Text('Go To Page of index 1'),
  //                 onPressed: () {
  //                   //Page change using state does the same as clicking index 1 navigation button
  //                   final CurvedNavigationBarState navBarState =
  //                       _bottomNavigationKey.currentState;
  //                   navBarState.setPage(1);
  //                 },
  //               )
  //             ],
  //           ),
  //         ),
  //       ));
  // }
}
