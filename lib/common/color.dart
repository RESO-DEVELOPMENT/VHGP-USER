import 'package:flutter/material.dart';

const Color primary = Color.fromARGB(255, 250, 159, 56);
const Color primary2 = Color(0xfff7892b);
const Color black = Color.fromRGBO(24, 23, 37, 1.0);
const Color secondary = Color.fromARGB(255, 6, 88, 155);
const Color white = Color.fromARGB(255, 255, 255, 255);
const Color grey = Color.fromRGBO(245, 245, 245, 1);
const Color success = Color.fromARGB(255, 0, 184, 116);
const Color sucessButtonPrimary = Color.fromRGBO(93, 229, 147, 1);
const Color sucessButtonSecondary = Color.fromRGBO(65, 214, 124, 1);

// const kPrimaryGreen = Color(0xFF54B175);
// const kPrimaryRed = Color(0xFFFE6E4C);
// const kPrimaryYellow = Color(0xFFFEBF43);
// const kPrimaryPurple = Color(0xFF9B81E5);
// const kPrimaryTosca = Color(0xFF03B0A9);
// const kAccentGreen = Color(0xFFE4F3EA);
// const kAccentRed = Color(0xFFFFECE8);
// const kAccentYellow = Color(0xFFFFF6E4);
// const kAccentPurple = Color(0xFFF1EDFC);
// const kAccentTosca = Color(0xFFDDF5F4);

/// Main color pallete
const kPrimaryGreen = Color(0xFF54B175);
const kPrimaryRed = Color(0xFFFE6E4C);
const kPrimaryYellow = Color(0xFFFEBF43);
const kPrimaryPurple = Color(0xFF9B81E5);
const kPrimaryTosca = Color(0xFF03B0A9);
const kAccentGreen = Color(0xFFE4F3EA);
const kAccentRed = Color(0xFFFFECE8);
const kAccentYellow = Color(0xFFFFF6E4);
const kAccentPurple = Color(0xFFF1EDFC);
const kAccentTosca = Color(0xFFDDF5F4);

///Text color
const kTextColor = Color(0xFF22292E);
const kTextColorAccent = Color(0xFF8A8A8E);
const kTextColorThird = Color(0xFFC5C5C7);
const kTextColorForth = Color(0xFFF8F8F8);

///common color for placeholder
const kGreyShade1 = Color(0xFF8E8E93);
const kGreyShade2 = Color(0xFFAEAEB2);
const kGreyShade3 = Color(0xFFC7C7CC);
const kGreyShade4 = Color(0xFFD1D1D6);
const kGreyShade5 = Color(0xFFE5E5EA);
const kGreyShade6 = Color(0xFFF2F2F7);
const kShadowColor = Color(0x3322292E);
const kSeperatorColor = Color(0xFFC6C6C8);
const kGradientColor = Color(0xFF22292E);
const kFillColorPrimary = Color(0xFFE4E4E6);
const kFillColorAccent = Color(0xFFE9E9EB);
const kFillColorThird = Color(0xFFEFEFF0);
const kFillColorForth = Color(0xFFF4F4F5);
const kAlertColor = Color(0xFFFF3B30);
const kFailColor = Color(0xFFFF4343);

class AppColors {
  // static bool isDarkMode = false;
  // static const Color primary = Color.fromRGBO(255, 170, 76, 1);
  // static const Color black = Color.fromRGBO(24, 23, 37, 1.0);
  // static const Color secondary = Color.fromRGBO(14, 105, 180, 1.0);
  // static const Color white = Color.fromARGB(255, 255, 255, 255);
  // static const Color grey = Color.fromRGBO(245, 245, 245, 1);
  // static const Color success = Color.fromARGB(176, 0, 163, 54);

  static ThemeData get getTheme => ThemeData(
        scaffoldBackgroundColor: grey,
        tabBarTheme: const TabBarTheme(
            labelColor: primary,
            labelStyle: TextStyle(fontFamily: "SF SemiBold", fontSize: 16),
            unselectedLabelColor: Colors.black54,
            unselectedLabelStyle:
                TextStyle(fontFamily: "SF SemiBold", fontSize: 16),
            indicator: UnderlineTabIndicator(
                // color for indicator (underline)
                borderSide: BorderSide(color: primary, width: 3))),
        fontFamily: 'SF Regular',
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: primary)),
        ),
      );

  static LinearGradient getLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        color[300]!,
        color[200]!,
        color[100]!,
      ],
      stops: const [
        0.4,
        0.7,
        0.9,
      ],
    );
  }

  static LinearGradient getDarkLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        color[400]!,
        color[300]!,
        color[200]!,
      ],
      stops: const [
        0.4,
        0.6,
        1,
      ],
    );
  }
}
