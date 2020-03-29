// import 'package:flutter_login_signup/allFiles.dart';

// // class ManagerDashboard extends StatefulWidget {
// //   @override
// //   _ManagerDashboardState createState() => _ManagerDashboardState();
// // }

// // class _ManagerDashboardState extends State<ManagerDashboard> {
//   // SocketIO socketIO;

//   // List messages;
//   // TextEditingController textController;
//   // int length;
//   // @override
//   // void iniState() {
//   //   super.initState();
//   //   socketIO.connect();

//   //   //Initializing the message list
//   //   print("object");
//   //   messages = List();
//   //   //Initializing the TextEditingController and ScrollController
//   //   textController = TextEditingController();
//   //   // scrollController = ScrollController();
//   //   //Creating the socket
//   //   socketIO = SocketIOManager().createSocketIO(
//   //     'https://hlmt.herokuapp.com',
//   //     '/api/sockets',
//   //   );
//   //   //Call init before doing anything with socket
//   //   socketIO.init();
//   //   //Subscribe to an event to listen to
//   //   socketIO.subscribe('test_socket', (jsonData) {
//   //     //Convert the JSON data received into a Map
//   //     Map<String, dynamic> data = json.decode(jsonData);
//   //     this.setState(() {
//   //       messages.add(data['status']);
//   //       length = data.length;
//   //       print(data['status']);
//   //     });

//   //     // scrollController.animateTo(
//   //     //   scrollController.position.maxScrollExtent,
//   //     //   duration: Duration(milliseconds: 600),
//   //     //   curve: Curves.ease,
//   //     // );
//   //   });
//   //   //Connect to the socket

//   // }

// //   SocketIO socketIO;
// //   List<String> messages;
// //   double height, width;
// //   TextEditingController textController;
// //   ScrollController scrollController;

// //   @override
// //   void initState() {

// //     // //Initializing the message list
// //     // // messages = List<String>();
// //     // //Initializing the TextEditingController and ScrollController
// //     // // textController = TextEditingController();
// //     // // scrollController = ScrollController();
// //     // // //Creating the socket
// //     socketIO = SocketIOManager().createSocketIO(
// //       'https://hlmt.herokuapp.com',
// //       '/',
// //     );
// //     // socketIO = SocketIOManager.create()
// //     // //Call init before doing anything with socket

// //     // //Subscribe to an event to listen to
// //     socketIO.subscribe('test_socket', (jsonData) {
// //     //   //Convert the JSON data received into a Map
// //     //   // Map<String, dynamic> data = json.decode(jsonData);
// //     //   // print(data['status']);
// //       print(jsonData);
// //     });
// //     //   // this.setState(() {
// //     //   //   messages.add(data['status']);
// //     //   //   print(data['status']);
// //     //   // });
// //     //   // scrollController.animateTo(
// //     //   //   scrollController.position.maxScrollExtent,
// //     //   //   duration: Duration(milliseconds: 600),
// //     //   //   curve: Curves.ease,
// //     //   // );
// //     // });
// //     // //Connect to the socket
// //     socketIO.connect();
// // super.initState();
// //     socketIO.init();
// //     // print("object");

// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         // bottomNavigationBar: CurvedNavigationBar(items: null),
// //         body: Column(
// //           children: <Widget>[
// //             Container(
// //               color: Color(0xfffe9263),
// //               padding: EdgeInsets.all(10),
// //               width: double.infinity,
// //               height: MediaQuery.of(context).size.height / 10,
// //               child: Text(
// //                 "NAme...",
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //             SingleChildScrollView(child: _listBuild()),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buttonContainer() {
// //     return Container(
// //         color: Colors.deepOrange[200],
// //         // margin: EdgeInsets.all(10),

// //         padding: EdgeInsets.all(10),
// //         child: Column(
// //           children: <Widget>[
// //             Text("hello"),
// //             Row(
// //               children: <Widget>[Text("Heelo"), Text("Hello")],
// //             )
// //           ],
// //         ));
// //   }

// //   Widget _listBuild() {
// //     return Container(
// //       height: MediaQuery.of(context).size.height / 10 * 8,
// //       child: ListView.builder(
// //           // itemCount: length == null ? 0 : length,
// //           itemCount: 15,
// //           itemBuilder: (BuildContext context, int index) {
// //             return SingleChildScrollView(
// //               child: Container(
// //                 margin: EdgeInsets.only(bottom: 10),
// //                 padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
// //                 color: Colors.white,
// //                 child: Center(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.stretch,
// //                     children: <Widget>[
// //                       ButtonTheme(
// //                         minWidth: double.infinity,
// //                         child: RaisedButton(
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(8.0),
// //                               // side: BorderSide(color: Colors.red)
// //                             ),
// //                             onPressed: () {
// //                               print(index);
// //                               // setState(() {
// //                               //   // pressAttention = !pressAttention;
// //                               //   print(data[index]);

// //                               //   setIndex(index);
// //                               //   r++;
// //                               //   print(r);
// //                               // });
// //                             },
// //                             // child: Text(data[index]["banks"]),
// //                             // child: Text(data[index]),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: <Widget>[
// //                                 Container(
// //                                     width: 40,
// //                                     height: 50,
// //                                     child: Image(
// //                                       image: AssetImage(
// //                                           "assets/images/helmet.png"),
// //                                     )),
// //                                 Column(
// //                                   children: <Widget>[
// //                                     Text("location"),
// //                                     // Text(messages[0]),
// //                                   ],
// //                                 )
// //                               ],
// //                             ),
// //                             color: Colors.white),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             );
// //           }),
// //       // height: MediaQuery.of(context).size.height / 2 - 100,
// //       margin: EdgeInsets.all(10),
// //       padding: EdgeInsets.all(10),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.all(
// //           Radius.circular(8.0),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_socket_io/flutter_socket_io.dart';
// import 'package:flutter_socket_io/socket_io_manager.dart';

// class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   SocketIO socketIO;
//   List<String> messages;
//   double height, width;
//   TextEditingController textController;
//   ScrollController scrollController;

//   @override
//   void initState() {
//     //Initializing the message list
//     messages = List<String>();
//     //Initializing the TextEditingController and ScrollController
//     textController = TextEditingController();
//     scrollController = ScrollController();
//     //Creating the socket
//     socketIO = SocketIOManager().createSocketIO(
//       'https://hlmt.herokuapp.com',
//       '/',
//     );

//     // socketIO = "";
//     //Call init before doing anything with socket
//     socketIO.init();
//     //Subscribe to an event to listen to
//     socketIO.subscribe('receive_message', (jsonData) {
//       //Convert the JSON data received into a Map
//       print(jsonData);
//       Map<String, dynamic> data = json.decode(jsonData);
//       this.setState(() => messages.add(data['message']));
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 600),
//         curve: Curves.ease,
//       );
//     });
//     //Connect to the socket
//     socketIO.connect();
//     super.initState();
//   }

//   Widget buildSingleMessage(int index) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
//         decoration: BoxDecoration(
//           color: Colors.deepPurple,
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Text(
//           messages[index],
//           style: TextStyle(color: Colors.white, fontSize: 15.0),
//         ),
//       ),
//     );
//   }

//   Widget buildMessageList() {
//     return Container(
//       height: height * 0.8,
//       width: width,
//       child: ListView.builder(
//         controller: scrollController,
//         itemCount: messages.length,
//         itemBuilder: (BuildContext context, int index) {
//           return buildSingleMessage(index);
//         },
//       ),
//     );
//   }

//   Widget buildChatInput() {
//     return Container(
//       width: width * 0.7,
//       padding: const EdgeInsets.all(2.0),
//       margin: const EdgeInsets.only(left: 40.0),
//       child: TextField(
//         decoration: InputDecoration.collapsed(
//           hintText: 'Send a message...',
//         ),
//         controller: textController,
//       ),
//     );
//   }

//   Widget buildSendButton() {
//     return FloatingActionButton(
//       backgroundColor: Colors.deepPurple,
//       onPressed: () {
//         //Check if the textfield has text or not
//         if (textController.text.isNotEmpty) {
//           //Send the message as JSON data to send_message event
//           socketIO.sendMessage(
//               'send_message', json.encode({'message': textController.text}));
//           //Add the message to the list
//           this.setState(() => messages.add(textController.text));
//           textController.text = '';
//           //Scrolldown the list to show the latest message
//           scrollController.animateTo(
//             scrollController.position.maxScrollExtent,
//             duration: Duration(milliseconds: 600),
//             curve: Curves.ease,
//           );
//         }
//       },
//       child: Icon(
//         Icons.send,
//         size: 30,
//       ),
//     );
//   }

//   Widget buildInputArea() {
//     return Container(
//       height: height * 0.1,
//       width: width,
//       child: Row(
//         children: <Widget>[
//           buildChatInput(),
//           buildSendButton(),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: height * 0.1),
//             buildMessageList(),
//             buildInputArea(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class History extends StatefulWidget {
//   @override
//   _HistoryState createState() => _HistoryState();
// }

// class _HistoryState extends State<History> {
//   SocketIO socketIO;
//   List<String> messages;
//   double height, width;
//   TextEditingController textController;
//   ScrollController scrollController;
//   Map<String,dynamic> nakul = {
//     "phone":"7071006000"
//   };

//   @override
//   void initState() {
//     //Initializing the message list
//     messages = List<String>();
//     //Initializing the TextEditingController and ScrollController
//     textController = TextEditingController();
//     scrollController = ScrollController();
//     //Creating the socket
//     socketIO = SocketIOManager().createSocketIO(
//       'https://hlmt.herokuapp.com',
//       '/',
//     );

//     // socketIO = "";
//     //Call init before doing anything with socket
//     socketIO.init();

//     //Subscribe to an event to listen to
//     socketIO.subscribe('check', (jsonData) {
//       //Convert the JSON data received into a Map
//       print(jsonData);
//       // Map<String, dynamic> data = json.decode(jsonData);
//       // this.setState(() => messages.add(data['message']));
//       // scrollController.animateTo(
//       //   scrollController.position.maxScrollExtent,
//       //   duration: Duration(milliseconds: 600),
//       //   curve: Curves.ease,
//       // );
//     });

//     //Connect to the socket
//     socketIO.connect();
//     socketIO.sendMessage('join', json.encode(nakul));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: Color(0xfffe9263),
//       body: Stack(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
//             width: MediaQuery.of(context).size.width,
//             height: 60,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30)),
//             ),
//             child: Text(
//               "History!",
//               style: TextStyle(color: Colors.black, fontSize: 30),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).size.height / 10 - 10,
//             ),
//             height: MediaQuery.of(context).size.height - 100,
//             child: ListView.builder(
//                 itemCount: 15,
//                 itemBuilder: (BuildContext context, int index) {
//                   return SingleChildScrollView(
//                     child: Container(
//                       child: Center(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: <Widget>[
//                             Card(
//                               child: Container(
//                                 child: Text("Checking\nCheck"),
//                                 padding: const EdgeInsets.all(20.0),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           )
//         ],
//       ),
//     ));
//   }
// }

// import 'package:flutter_login_signup/allFiles.dart';

// class ManagerDashboard extends StatefulWidget {
//   @override
//   _ManagerDashboardState createState() => _ManagerDashboardState();
// }

// class _ManagerDashboardState extends State<ManagerDashboard> {
// SocketIO socketIO;

// List messages;
// TextEditingController textController;
// int length;
// @override
// void iniState() {
//   super.initState();
//   socketIO.connect();

//   //Initializing the message list
//   print("object");
//   messages = List();
//   //Initializing the TextEditingController and ScrollController
//   textController = TextEditingController();
//   // scrollController = ScrollController();
//   //Creating the socket
//   socketIO = SocketIOManager().createSocketIO(
//     'https://hlmt.herokuapp.com',
//     '/api/sockets',
//   );
//   //Call init before doing anything with socket
//   socketIO.init();
//   //Subscribe to an event to listen to
//   socketIO.subscribe('test_socket', (jsonData) {
//     //Convert the JSON data received into a Map
//     Map<String, dynamic> data = json.decode(jsonData);
//     this.setState(() {
//       messages.add(data['status']);
//       length = data.length;
//       print(data['status']);
//     });

//     // scrollController.animateTo(
//     //   scrollController.position.maxScrollExtent,
//     //   duration: Duration(milliseconds: 600),
//     //   curve: Curves.ease,
//     // );
//   });
//   //Connect to the socket

// }

//   SocketIO socketIO;
//   List<String> messages;
//   double height, width;
//   TextEditingController textController;
//   ScrollController scrollController;

//   @override
//   void initState() {

//     // //Initializing the message list
//     // // messages = List<String>();
//     // //Initializing the TextEditingController and ScrollController
//     // // textController = TextEditingController();
//     // // scrollController = ScrollController();
//     // // //Creating the socket
//     socketIO = SocketIOManager().createSocketIO(
//       'https://hlmt.herokuapp.com',
//       '/',
//     );
//     // socketIO = SocketIOManager.create()
//     // //Call init before doing anything with socket

//     // //Subscribe to an event to listen to
//     socketIO.subscribe('test_socket', (jsonData) {
//     //   //Convert the JSON data received into a Map
//     //   // Map<String, dynamic> data = json.decode(jsonData);
//     //   // print(data['status']);
//       print(jsonData);
//     });
//     //   // this.setState(() {
//     //   //   messages.add(data['status']);
//     //   //   print(data['status']);
//     //   // });
//     //   // scrollController.animateTo(
//     //   //   scrollController.position.maxScrollExtent,
//     //   //   duration: Duration(milliseconds: 600),
//     //   //   curve: Curves.ease,
//     //   // );
//     // });
//     // //Connect to the socket
//     socketIO.connect();
// super.initState();
//     socketIO.init();
//     // print("object");

//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // bottomNavigationBar: CurvedNavigationBar(items: null),
//         body: Column(
//           children: <Widget>[
//             Container(
//               color: Color(0xfffe9263),
//               padding: EdgeInsets.all(10),
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height / 10,
//               child: Text(
//                 "NAme...",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SingleChildScrollView(child: _listBuild()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buttonContainer() {
//     return Container(
//         color: Colors.deepOrange[200],
//         // margin: EdgeInsets.all(10),

//         padding: EdgeInsets.all(10),
//         child: Column(
//           children: <Widget>[
//             Text("hello"),
//             Row(
//               children: <Widget>[Text("Heelo"), Text("Hello")],
//             )
//           ],
//         ));
//   }

//   Widget _listBuild() {
//     return Container(
//       height: MediaQuery.of(context).size.height / 10 * 8,
//       child: ListView.builder(
//           // itemCount: length == null ? 0 : length,
//           itemCount: 15,
//           itemBuilder: (BuildContext context, int index) {
//             return SingleChildScrollView(
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 10),
//                 padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
//                 color: Colors.white,
//                 child: Center(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       ButtonTheme(
//                         minWidth: double.infinity,
//                         child: RaisedButton(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                               // side: BorderSide(color: Colors.red)
//                             ),
//                             onPressed: () {
//                               print(index);
//                               // setState(() {
//                               //   // pressAttention = !pressAttention;
//                               //   print(data[index]);

//                               //   setIndex(index);
//                               //   r++;
//                               //   print(r);
//                               // });
//                             },
//                             // child: Text(data[index]["banks"]),
//                             // child: Text(data[index]),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Container(
//                                     width: 40,
//                                     height: 50,
//                                     child: Image(
//                                       image: AssetImage(
//                                           "assets/images/helmet.png"),
//                                     )),
//                                 Column(
//                                   children: <Widget>[
//                                     Text("location"),
//                                     // Text(messages[0]),
//                                   ],
//                                 )
//                               ],
//                             ),
//                             color: Colors.white),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//       // height: MediaQuery.of(context).size.height / 2 - 100,
//       margin: EdgeInsets.all(10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(
//           Radius.circular(8.0),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter_login_signup/allFiles.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_login_signup/allFiles.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ManagerDashboard extends StatefulWidget {
  @override
  _ManagerDashboardState createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  SocketIO socketIO;
  TextEditingController _contro;
  List data;
  int hel = 350;

  bool q = false;
  bool w = true;
  String h;
  String managerMobile;

  void getData() async {
    var data1 = await http.post(
        "https://hlmt.herokuapp.com/api/managers/history",
        headers: headers,
        body: '{"bank_id": "$h"}');
    print(data1.body);
    String data2 = data1.body;
    var data3 = json.decode(data2);
    // print(data3["transaction"]);
    print("\n\n\n");
    print(data3["transactions"]);
    print("object.....");
    if (data1.statusCode == 200) {
      if (data3["status"] == "true") {
        data = data3["transactions"];
        print(data.length);
        print(data);
        setState(() {
          q = true;
        });
      } else if (data3["status"] == "false") {
        setState(() {
          w = false;
        });
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Server Error"),
      ));
    }
  }

  void join() async {
    await socketIO.sendMessage(
        "join", json.encode({"phone": "$managerMobile"}));
  }

  void sendDataTap() async {}

  void initState() {
    h = getBank();
    managerMobile = getManagerMobile();

    getData();

    socketIO = SocketIOManager().createSocketIO(
      'https://hlmt.herokuapp.com',
      '/',
    );
    join();

    socketIO.init();
    // socketIO.subscribe("outgoing", (jsonData1) {
    //   var qw1 = json.decode(jsonData1);
    //   print("$qw1 is status....");
    // });
    socketIO.subscribe("incoming", (jsondata) {
      // print(jsondata);

      String jsonData1 = jsondata;
      var qw = json.decode(jsonData1);
      print(qw);
      print("I am herereee");
      setState(() {
        print("Comming here.......");
        q = true;
        data.add(qw);

        print("immmm\n\n\n\n\n\n\n");
        print(qw);
      });

      // setState(() {
      //   data.add(value)
      // });
    });
    socketIO.connect();
    // print("up");
    super.initState();
    // print("Down");
  }

  showAlertDialog(BuildContext context, String title) {
    // String title;
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Booking Status"),
      content: TextFormField(
        controller: _contro,
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // bottomNavigationBar: CurvedNavigationBar(items: null),
      // backgroundColor: Color(0xfffe9263),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            // color: Color(0xfffe9263),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 20,
            child: Center(
              child: Text(
                "NAme...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _listBuild(),
        ],
      ),
    ));
  }

  Widget _listBuild() {
    return q
        ? SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.20,
              child: ListView.builder(
                  itemCount: data.length == null ? 0 : data.length,
                  // itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xfffe9263),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(width: 1, style: BorderStyle.solid)),
                        margin: EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                        // color: Colors.white,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              // ButtonTheme(
                              //   minWidth: double.infinity,
                              w
                                  ? Container(
                                      padding: EdgeInsets.all(5),
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(data[index]["transaction_id"]),
                                          Text(data[index]["user"]),
                                          // Container(width:30,child:TextField(controller: _contro,)),
                                          data[index]["issue_datetime"] ==
                                                  "null"
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      width: 100,
                                                      height: 40,
                                                      child: InkWell(
                                                        child: Center(
                                                            child:
                                                                Text("Accept")),
                                                        onTap: () {
                                                          hel++;
                                                          print(_contro);
                                                          // setState(() {
                                                          //   _contro.clear();
                                                          // });
                                                          showAlertDialog(
                                                              context,
                                                              "Enter Helmet Number");
                                                          // print(_contro);

                                                          socketIO.sendMessage(
                                                              "outgoing",
                                                              json.encode({
                                                                "body": {
                                                                  "transaction_id":
                                                                      data[index]
                                                                          [
                                                                          "transaction_id"],
                                                                  "approved": 1,
                                                                  "helmet_no":
                                                                      hel,
                                                                  "manager":
                                                                      managerMobile
                                                                }
                                                              }));

                                                          print(data[index][
                                                              "transaction_id"]);

                                                          setState(() {
                                                            data.removeAt(
                                                                index);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: InkWell(
                                                        child: Center(
                                                            child: Text(
                                                                "Decline")),
                                                        onTap: () {
                                                          socketIO.sendMessage(
                                                              "outgoing",
                                                              json.encode({
                                                                "body": {
                                                                  "transaction_id":
                                                                      data[index]
                                                                          [
                                                                          "transaction_id"],
                                                                  "approved": 0,
                                                                  "manager":
                                                                      managerMobile
                                                                }
                                                              }));
                                                          setState(() {
                                                            data.removeAt(
                                                                index);
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Container(
                                                  width: 50,
                                                  height: 50,
                                                  child: InkWell(
                                                    onTap: () {
                                                      print("object");
                                                      socketIO.sendMessage(
                                                          "complete",
                                                          json.encode({
                                                            "body": {
                                                              "transaction_id":
                                                                  int.parse(data[
                                                                          index]
                                                                      [
                                                                      "transaction_id"]),
                                                              "manager":
                                                                  managerMobile,
                                                            }
                                                          }));
                                                      setState(() {
                                                        data.removeAt(index);
                                                      });
                                                    },
                                                    child:
                                                        Text("Helmet Recieved"),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      // color: Colors.blue[200],
                                    )
                                  : Container(
                                      child: Center(
                                        child: Text("No pending requests"),
                                      ),
                                    )
                              // )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              // height: MediaQuery.of(context).size.height / 2 - 100,
              // margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                // color: Colors.white,
                // color: Color(0xfffe9263),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          )
        : Center(child: Text("Getting dataaa..."));
  }
}
