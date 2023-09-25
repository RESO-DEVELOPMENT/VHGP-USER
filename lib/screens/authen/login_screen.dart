import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinhome_user/common/color.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/authentication_controller.dart';
import 'package:vinhome_user/screens/routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences prefs;
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  final _formKey = GlobalKey<FormState>();
  final _controllerUserName = TextEditingController();
  final _controllerPass = TextEditingController();
  String _textUserName = '';
  String _textPass = '';
  bool isLoading = false;
  bool isLogin = true;

  Future<void> handleSignInEmail() async {
    authenticationController.login(_textUserName, _textPass);
  }

  void getUser() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      String strUser = prefs.getString("user") ?? '';
      if (strUser != '') {
        print('ok');
        Get.offAllNamed(Routes.tabScreen);
      }
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Widget _entryField(
      String title, String error, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: "SF Bold",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return error;
                }
                return null;
              },
              controller: controller,
              onChanged: (e) => {
                    if (controller == _controllerUserName)
                      {setState(() => _textUserName = e)}
                    else if (controller == _controllerPass)
                      {setState(() => _textPass = e)}
                  },
              obscureText: isPassword,
              decoration: InputDecoration(
                  labelText: "user",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  border: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  fillColor: Colors.black12,
                  filled: true))
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _entryField(
            "Tên đăng nhập",
            "Vui lòng nhập tên đăng nhập",
            _controllerUserName,
          ),
          _entryField(
            "Mật khẩu",
            "Vui lòng nhập mật khẩu",
            _controllerPass,
            isPassword: true,
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GetBuilder<AuthenticationController>(
      builder: (controller) => InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (_formKey.currentState!.validate()) {
            handleSignInEmail();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
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
                    primary,
                    primary2,
                  ])),
          child: controller.isLoading
              ? Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(2.0),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: "SF Bold",
                  ),
                ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return GetBuilder<AuthenticationController>(
      builder: (controller) => InkWell(
        onTap: () {
          Get.toNamed(Routes.register);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
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
                    Color.fromRGBO(170, 178, 189, 1),
                    Color.fromRGBO(209, 208, 208, 1),
                  ])),
          child: const Text(
            'Đăng kí',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: "SF Bold",
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      text: TextSpan(
          text: 'VHGP',
          style: TextStyle(
              fontFamily: "SF Heavy",
              fontSize: 28,
              // fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
                text: '  Tiện tích cư dân', style: Get.textTheme.titleLarge),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        GetBuilder<AuthenticationController>(
          builder: (controller) => SizedBox(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: const BezierContainer()),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        const SizedBox(height: 50),
                        _emailPasswordWidget(),
                        "FAIL" == controller.isAuthen
                            ? const Text(
                                "Tài khoản hoặc mật khẩu không đúng",
                                style: TextStyle(
                                    color: Color.fromRGBO(217, 48, 37, 1)),
                              )
                            : Container(),
                        if (!isLogin)
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                                "Tên đăng nhập hoặc mật khẩu không đúng!",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "SF Medium",
                                    color: Color.fromARGB(255, 223, 21, 6))),
                          ),
                        const SizedBox(height: 20),
                        _submitButton(),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: const Text('Quên mật khẩu ?',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                        ),
                        _registerButton(),
                        SizedBox(height: height * .055),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading) ...[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white.withOpacity(0.5),
            child: const SpinKitFoldingCube(
              color: primary,
              size: 50.0,
            ),
          )
        ],
      ],
    ));
  }
}

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 3.5,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                primary,
                primary2,
              ])),
        ),
      ),
    );
  }
}

class ClipPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, height);
    path.lineTo(size.width, 0);

    /// [Top Left corner]
    var secondControlPoint = const Offset(0, 0);
    var secondEndPoint = Offset(width * .2, height * .3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    /// [Left Middle]
    var fifthControlPoint = Offset(width * .3, height * .5);
    var fiftEndPoint = Offset(width * .23, height * .6);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fiftEndPoint.dx, fiftEndPoint.dy);

    /// [Bottom Left corner]
    var thirdControlPoint = Offset(0, height);
    var thirdEndPoint = Offset(width, height);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
