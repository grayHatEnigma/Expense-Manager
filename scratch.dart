void main() {
  bool x1 = true;
  bool x2 = false;

  bool result = !(x1 ^ x2);
  bool showAll = !result;

  print(showAll);
}

class Test {
  static int counter = 0;
  static final Test instance = Test._privateConstructor();
  factory Test() {
    print('factory constructor');

    return instance;
  }

  Test._privateConstructor() {
    print(
        'private constructor called ${++counter} time${counter > 0 ? '' : 's'}');
  }
}
