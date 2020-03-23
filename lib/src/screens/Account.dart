import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/screens/dashboard.dart';
import 'history.dart';

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
                        ),
                  ));
            }
          },
        ),
        backgroundColor: Color(0xfffe9263),
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 10,
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
