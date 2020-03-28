import 'dart:math';

double shannonToCkb(String shannon) {
  return double.parse(shannon) / pow(10, 8);
}
