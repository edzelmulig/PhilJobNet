import 'dart:math';

// FUNCTION TO GENERATE 6-DIGIT RANDOM NUMBER
String generateRandomNumber() {
  final random = Random();
  String randomNumber = '';
  for (int i = 0; i < 5; i++) {
    randomNumber += random.nextInt(10).toString();
  }
  return randomNumber;
}