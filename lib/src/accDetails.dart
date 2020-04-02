

Map<String,dynamic> _userDataa;
bool _bar;
String title;

void setUser(Map<String,dynamic> user,bool navBar) {
  _userDataa = user;
  _bar = navBar;
}

void setTitle(String _title){
  title  =_title;
}

String getTitle(){
  return title;
}


Map<String,dynamic> getUser(){
  return _userDataa;
  
}

bool isBar(){
  return _bar;
}

