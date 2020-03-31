// class AccountPerson {
//   final String name;
//   final String phone;
//   final int totalHelmet;
//   final int availHelmet;

//   AccountPerson({this.name, this.phone, this.totalHelmet, this.availHelmet});

//   String get nameGet {
//     if(name == null)
//     {
//       return "qqq";
//     }
//     return name;
//   }

//   int get totalHelmetNo {
//      if(name == null)
//     {
//       return 0;
//     }
//     return this.totalHelmet;
//   }

//   int get availHelmetNo {
//      if(name == null)
//     {
//       return 0;
//     }
//     return this.availHelmet;
//   }

//   // set nameSet(String nameComing) {
//   //   name = nameComing;
//   // }
// }

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
