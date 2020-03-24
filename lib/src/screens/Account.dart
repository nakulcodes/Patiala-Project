import 'package:flutter_login_signup/allFiles.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: 2,
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
                    builder: (context) => History(
                        // index: index,
                        ),
                  ));
            } else if (index == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(
                        // index: index,
                        count: 1,
                        ),
                  ));
            }
          },
        ),
        backgroundColor: Color(0xfffe9263),
        body: Column(
          children: <Widget>[
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
            ),
            Center(
              child: Text("MyAccount"),
            ),
          ],
        ),
      ),
    );
  }
}
