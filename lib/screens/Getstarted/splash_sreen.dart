import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vinhome_user/controllers/authentication_controller.dart';
import 'package:vinhome_user/screens/routes/routes.dart';

class SplashSreen extends StatefulWidget {
  const SplashSreen({Key? key}) : super(key: key);

  @override
  _SplashSreenState createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashSreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  String logo = 'assets/images/app_logo.png';
  List<AssetImage> splash_img = [
    AssetImage('assets/images/splash_1.png'),
    AssetImage('assets/images/splash_2.png'),
    AssetImage('assets/images/splash_3.png'),
    AssetImage('assets/images/splash_4.png'),
  ];
  List<String> header_text = [
    'Welcome to',
    'Buy Quality Dairy Products',
    'Buy Premium Quality Fruits',
    'Get Discounts On All Products'
  ];

  String splash_text_head = 'Welcome to ';

  Widget _LoginButton() {
    return GetBuilder<AuthenticationController>(
      builder: (controller) => InkWell(
        onTap: () {
          Get.toNamed(Routes.login);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          // padding: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(255, 53, 35, 1),
                    Color.fromRGBO(255, 133, 67, 1),
                  ])),
          child: const Text(
            'Get started',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
              fontFamily: "SF Bold",
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageview(AssetImage image_bg, String header) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: image_bg,
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(children: [
        Column(children: [
          Text(header),
          Image.asset(logo),
          Text(
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy"),
          _LoginButton()
        ]),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter PageView',
        home: Scaffold(
          body: PageView(children: [
            _pageview(splash_img[0], header_text[0]),
            _pageview(splash_img[1], header_text[1])
          ]),
        ));
  }
}
