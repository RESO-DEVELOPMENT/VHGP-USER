import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vinhome_user/common/color.dart';
import 'package:vinhome_user/utils/date.dart';

import 'firebase_options.dart';
import 'screens/routes/routes.dart';
import 'utils/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = await PostHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // final customTheme = CustomTheme(constraints);
        return GetMaterialApp(
          title: 'VHGP User',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              fontFamily: GoogleFonts.inter().fontFamily,
              colorSchemeSeed: Colors.orangeAccent),
          initialRoute: Routes.demo,
          getPages: RouterGenerator.pages,
        );
      },
    );
  }
}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
