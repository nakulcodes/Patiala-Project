import 'package:flutter_login_signup/allFiles.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xfffe9263),
      // bottomNavigationBar: CurvedNavigationBar(
      //   index: 1,
      //   height: 50,
      //   backgroundColor: Color(0xfffe9263),
      //   items: <Widget>[
      //     Icon(Icons.home, size: 30),
      //     Icon(Icons.history, size: 30),
      //     Icon(Icons.account_circle, size: 30),
      //   ],
      //   onTap: (index) {
      //     //Handle button tap
      //     print(index);
      //     if (index == 0) {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => Dashboard()));
      //       // Navigator.pop(context);
      //     } else if (index == 2) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => Account(),
      //         ),
      //       );
      //     } else if (index == 2) {
      //       print("About");
      //     }
      //   },
      // ),
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
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: MediaQuery.of(context).size.height - 150,
            // margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                      // child: Container(
                      //   child: Center(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.stretch,
                      //       children: <Widget>[
                      child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text("Check"), Text("Check")],
                          ),
                          Column(children: <Widget>[
                            // Text(
                            //   ".",
                            //   style:
                            //       TextStyle(color: Colors.green, fontSize: 100),
                            // ),
                            // Icon(Icons.change_history)
                            Text("Check")
                          ])
                        ],
                      ),
                    ),
                  ));
                }),
          )
        ],
      ),
    ));
  }
}
