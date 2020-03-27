import 'package:flutter_login_signup/allFiles.dart';

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



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  SocketIO socketIO;
  List<String> messages;
  double height, width;
  TextEditingController textController;
  ScrollController scrollController;

  @override
  void initState() {
    //Initializing the message list
    messages = List<String>();
    //Initializing the TextEditingController and ScrollController
    textController = TextEditingController();
    scrollController = ScrollController();
    //Creating the socket
    socketIO = SocketIOManager().createSocketIO(
      'https://hlmt.herokuapp.com',
      '/',
    );

    // socketIO = "";
    //Call init before doing anything with socket
    socketIO.init();
    //Subscribe to an event to listen to
    socketIO.subscribe('receive_message', (jsonData) {
      //Convert the JSON data received into a Map
      print(jsonData);
      Map<String, dynamic> data = json.decode(jsonData);
      this.setState(() => messages.add(data['message']));
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
    //Connect to the socket
    socketIO.connect();
    super.initState();
  }

  Widget buildSingleMessage(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          messages[index],
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return Container(
      height: height * 0.8,
      width: width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return buildSingleMessage(index);
        },
      ),
    );
  }

  Widget buildChatInput() {
    return Container(
      width: width * 0.7,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(left: 40.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: 'Send a message...',
        ),
        controller: textController,
      ),
    );
  }

  Widget buildSendButton() {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () {
        //Check if the textfield has text or not
        if (textController.text.isNotEmpty) {
          //Send the message as JSON data to send_message event
          socketIO.sendMessage(
              'send_message', json.encode({'message': textController.text}));
          //Add the message to the list
          this.setState(() => messages.add(textController.text));
          textController.text = '';
          //Scrolldown the list to show the latest message
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        }
      },
      child: Icon(
        Icons.send,
        size: 30,
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      height: height * 0.1,
      width: width,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: height * 0.1),
            buildMessageList(),
            buildInputArea(),
          ],
        ),
      ),
    );
  }
}