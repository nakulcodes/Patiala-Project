int _i;

void setIndex(int i) {
  _i = i;
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
