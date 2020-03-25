import 'package:flutter_login_signup/allFiles.dart';

class Dashboard extends StatefulWidget {
  bool bar;
  Dashboard({this.bar});
  _DashboardState createState() => _DashboardState(bar: bar);
  // bottom: bottom, perDash: perDash, count: count);
}

class _DashboardState extends State<Dashboard> {
  List data;
  String nameUser;
  String availUser;
  String totalUser;
  String check;
  bool bar;
  _DashboardState({this.bar});

  @override
  void initState() {
    super.initState();
    this.getUserData();
  }

  String getUserData() {
    var q = getUser();
    data = q["banks"];
    nameUser = q["name"];
    availUser = q["available_helmets"];
    totalUser = q["total_helmets"];
    check = data.length.toString();

    return "Working.....";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffe9263),
        // backgroundColor: Colors.white,
        bottomNavigationBar: bar?_bottomNavBar():null,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _topHome(),
              _listBuild(),
              _avail(),
            ],
          ),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  //!    "Hi! $name",
                  "Hi!  $nameUser",
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
    );
  }

  Widget _listBuild() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
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
                        minWidth: double.infinity,
                        child: RaisedButton(
                          onPressed: () => print("object"),
                          // child: Text(data[index]["banks"]),
                          child: Text(data[index]),
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
    );
  }

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

  Widget _bottomNavBar() {
    return CurvedNavigationBar(
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
    );
  }
}
