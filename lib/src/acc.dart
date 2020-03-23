class Acc {
  String id;
  String password;

  Acc({this.id, this.password});

  Future<int> check() async {
    print(id + password);
    return 1;
  }
}

int check(){
  return 1;

}
