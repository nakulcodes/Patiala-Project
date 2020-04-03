import 'allFiles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    'loginPage': (context) => LoginPage(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    
  },
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  moveNext() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
// Here you can write your code
    });
  }

  @override
  void initState() {
    super.initState();
    moveNext();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 200,
            height: 200,
            child:
                Hero(tag: 'logo', child: Image.asset("assets/images/road.png")),
          ),
        ),
      ),
    );
  }
}
