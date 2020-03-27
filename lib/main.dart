import 'allFiles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '0': (context) => Dashboard(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '1': (context) => History(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home:ChatPage(),
      // home: ManagerDashboard(),
    );
  }
}
