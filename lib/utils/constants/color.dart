import 'package:flutter/material.dart';

Color main1Color = const Color(0xff296142);
Color main2Color = const Color(0xff296142).withValues(alpha: 0.7);

Color sub1Color = const Color(0xffE3A44F);
Color sub2Color = const Color(0xffE3A44F).withValues(alpha: 0.7);

Color key1Color = const Color.fromARGB(255, 27, 27, 27);
Color key2Color = const Color(0xff2A2A2A);

Color state1 = const Color(0xffE0E0E0);
Color state2 = const Color(0xffF4F1F3);

Color baseColor = const Color(0xffF3F6F9);
Color keyBlack = const Color(0xff1A2A4D);

LinearGradient mainGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: const Alignment(1, 0.8),
  colors: [
    const Color(0xff296142),
    const Color(0xff296142).withValues(alpha: 0.7),
  ],
);
LinearGradient asdjajsdhasjidas = LinearGradient(
  begin: Alignment.topLeft,
  end: const Alignment(1, 0.8),
  colors: [
    const Color(0xff296142).withValues(alpha: 0.1),
    const Color(0xff296142).withValues(alpha: 0.7),
  ],
);
LinearGradient mainGradient2 = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: [
    Color(0xff66D5FF),
    Color(0xff4EB2FF),
  ],
);
LinearGradient mainGradientgray = LinearGradient(
  begin: Alignment.topLeft,
  end: const Alignment(0.8, 1),
  colors: [
    key1Color.withValues(alpha: 0.3),
    key1Color.withValues(alpha: 0.3),
  ],
);
LinearGradient mainGradient3 = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: [
    Color(0xffF8777C),
    Color(0xffED1C24),
  ],
);
LinearGradient mainGradient4 = LinearGradient(
  begin: Alignment.topLeft,
  end: const Alignment(0.8, 1),
  colors: [
    key1Color.withValues(alpha: 0.3),
    key1Color.withValues(alpha: 0.3),
  ],
);
