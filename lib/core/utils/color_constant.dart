import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color green300 = fromHex('#5bd98c');

  static Color lightBlue1004c = fromHex('#4cb7e3f4');

  static Color bluegray50 = fromHex('#eef0f2');

  static Color red403 = fromHex('#ef4958');

  static Color bluegray90066 = fromHex('#661d3754');

  static Color bluegray1003f = fromHex('#3fd3d1d8');

  static Color lightBlue100 = fromHex('#b7e3f4');

  static Color red400 = fromHex('#dd565c');

  static Color deepOrange40066 = fromHex('#66fe724c');

  static Color red40019 = fromHex('#19dd565c');

  static Color gray9000a = fromHex('#0a14171a');

  static Color red4004c = fromHex('#4cdd565c');

  static Color bluegray1004c = fromHex('#4cd3d1d8');

  static Color gray600 = fromHex('#6c6c6c');

  static Color gray601 = fromHex('#6f6f6f');

  static Color gray964 = fromHex('#212121');

  static Color gray602 = fromHex('#6e6e6e');

  static Color gray603 = fromHex('#6d6d6d');

  static Color gray200 = fromHex('#efeff0');

  static Color bluegray800 = fromHex('#2b445e');

  static Color indigo200 = fromHex('#93bbd5');

  static Color bluegray402 = fromHex('#7d8391');

  static Color bluegray401 = fromHex('#7988a3');

  static Color bluegray400 = fromHex('#898989');

  static Color bluegray200 = fromHex('#aeb0b6');

  static Color cyan800 = fromHex('#2d7793');

  static Color blue100 = fromHex('#bee5ff');

  static Color whiteA700 = fromHex('#ffffff');

  static Color deepOrange40040 = fromHex('#40fe724c');

  static Color teal50B2 = fromHex('#b2cfecf8');

  static Color greenA200 = fromHex('#53e58c');

  static Color gray50 = fromHex('#fafafa');

  static Color teal200 = fromHex('#6eb4b8');

  static Color teal400 = fromHex('#2b9299');

  static Color teal201 = fromHex('#88bdd8');

  static Color black90066 = fromHex('#66000000');

  static Color black900 = fromHex('#000000');

  static Color bluegray900B2 = fromHex('#b21d3754');

  static Color indigo2004c = fromHex('#4c93bbd5');

  static Color bluegray9007f = fromHex('#7f1d3754');

  static Color deepPurpleA700 = fromHex('#3a00e5');

  static Color gray501 = fromHex('#a7a7a7');

  static Color gray700 = fromHex('#636363');

  static Color gray502 = fromHex('#9796a1');

  static Color gray500 = fromHex('#a5a5a5');

  static Color gray701 = fromHex('#61646b');

  static Color gray900 = fromHex('#18191a');

  static Color gray702 = fromHex('#5c5c5c');

  static Color bluegray100 = fromHex('#d9d9d9');

  static Color teal50 = fromHex('#dfebf2');

  static Color indigo20099 = fromHex('#9993bbd5');

  static Color gray100 = fromHex('#eff3fd');

  static Color bluegray900 = fromHex('#1d3754');

  static Color whiteA70087 = fromHex('#87ffffff');

  static Color indigoA400 = fromHex('#3563e9');

  static Color bluegray101 = fromHex('#cbd5e0');

  static Color indigo30028 = fromHex('#287a80be');

  static Color bluegray9004c = fromHex('#4c1d3754');

  static Color bluegray7001e = fromHex('#1e3f4b5e');

  static Color bluegray90019 = fromHex('#191d3754');

  static Color bluegray901 = fromHex('#1f3252');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
