import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/common/color.dart';

import 'screens/routes/routes.dart';
import 'utils/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final customTheme = CustomTheme(constraints);
        return GetMaterialApp(
          title: 'Vinhome User',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: white,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
            ),
            primarySwatch: Colors.orange,
            textTheme: customTheme.nunito(),
            elevatedButtonTheme: customTheme.elevatedButtonTheme(),
            outlinedButtonTheme: customTheme.outlinedButtonTheme(),
            textButtonTheme: customTheme.textButtonTheme(),
            dividerTheme: customTheme.dividerTheme(),
          ),
          initialRoute: Routes.login,
          getPages: RouterGenerator.pages,
        );
      },
    );
  }
}
