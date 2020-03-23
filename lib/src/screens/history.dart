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
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
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
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Account(),
              ),
            );
          } else if (index == 2) {
            print("About");
          }
        },
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 10 - 20,
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
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 10 - 10,
            ),
            height: MediaQuery.of(context).size.height - 100,
            child: ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Card(
                              child: Container(
                                child: Text("Checking\nCheck"),
                                padding: const EdgeInsets.all(20.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    ));
  }
}
