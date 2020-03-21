import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffbb448),
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          backgroundColor: Color(0xfffbb448),
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.history, size: 30),
            Icon(Icons.account_circle, size: 30),
          ],
          onTap: (index) {
            //Handle button tap
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                // margin: EdgeInsets.fromLTRB(5, 10, 10,0),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    // gradient: LinearGradient(
                    //     begin: Alignment.centerLeft,
                    //     end: Alignment.centerRight,
                    //     colors: [Color(0xfffbb448), Color(0xfff7892b)])
                    ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Hi! Nakul ",
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "10",
                                  style: TextStyle(
                                      color: Color(0xfffbb448), fontSize: 40),
                                ),
                                Text(
                                  "Number of\n\t\tHelmets",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "10",
                                  style: TextStyle(
                                      color: Color(0xfffbb448), fontSize: 40),
                                ),
                                Text(
                                  "Helmets\n\tAlloted",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
