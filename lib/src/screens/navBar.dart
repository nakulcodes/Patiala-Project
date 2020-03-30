import 'package:flutter_login_signup/allFiles.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _page = 0;
  Widget _showPage;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final History _history = History();
  final Dashboard _dashboard = Dashboard();
  final Account _account = Account();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _dashboard;
      case 1:
        return _history;
      case 2:
        return _account;
      default:
        return Center(
          child: Text("Page Not found"),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    _showPage = _pageChooser(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffe9263),
      bottomNavigationBar: CurvedNavigationBar(
        // color: Color(0xfffe9263),
        // buttonBackgroundColor: Color(0xfffe9263),
        backgroundColor: Color(0xfffe9263),
        index: _page,
        height: 50,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.history, size: 30),
          // Icon(Icons.account_circle, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _showPage = _pageChooser(index);
          });
        },
      ),
      body: Container(
        // child: _pageChooser(_page),
        child: _showPage,
      ),
    );
  }
}
