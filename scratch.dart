void main() {
  print('scratch file');
  final test1 = Test();
  final test2 = Test();
  final test3 = Test.instance;

  print('is identical ? ${identical(test1, test3)}');
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
