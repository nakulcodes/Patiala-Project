int _i ;

bool setIndex(int i) {
  if(i==_i){
    // _i =0;
    return false;
  }
  _i = i;
  return true;
}


int getIndex(){
  return _i;
}

bool returnIndex(int count, int q) {
  print("$count returnIndexmain hun main");
  if (count > 0) {
    if (q == _i) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
  
}
