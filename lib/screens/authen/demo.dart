import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:vinhome_user/controllers/authentication_controller.dart';
import 'package:vinhome_user/screens/authen/login_screen.dart';

class demo extends StatefulWidget {
  @override
  _demo createState() => _demo();
}

class _demo extends State<demo> {
  final _controllerPhoneNumber = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String _PhoneNumber = '';
  String _CoutryCode = '+84';
  String _errorPhoneInput = '';

  String _nameUser = 'Guest';
  String _verID = '';
  String _otpInput = '';

  int _timeleft = 60;
  int screen = 0;
  TextStyle style = TextStyle(
    color: Color.fromARGB(255, 134, 136, 137),
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  void verifyPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: _PhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verID, smsCode: _otpInput);

    await auth.signInWithCredential(credential).then((value) {
      print("You are logged in successfully");
    });
  }

  void _CountDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeleft > 0) {
        setState(() {
          _timeleft--;
        });
      }
    });
  }

  Widget _enterPhoneNumber() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IntlPhoneField(
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
              dropdownTextStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(9)
              ],
              invalidNumberMessage: "Số điện thoại nhập không đúng",
              disableLengthCheck: true,
              controller: _controllerPhoneNumber,
              showCountryFlag: true,
              showDropdownIcon: false,
              initialValue: _CoutryCode,
              onCountryChanged: (country) {
                setState(() {
                  _CoutryCode = "+" + country.dialCode;
                });
              },
              onChanged: (value) {
                _PhoneNumber = _CoutryCode + value.number;
              },
              flagsButtonPadding: EdgeInsets.only(left: 10),
              decoration: InputDecoration(
                labelText: "Số điện thoại",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 168, 167, 167),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 20,
                  letterSpacing: 0.1,
                  fontFamily: "Inter",
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
              )),
          SizedBox(
            height: 15,
          ),
          Text(
            "$_errorPhoneInput",
            style: TextStyle(color: Colors.red),
          )
        ]);
  }

  Widget _otpScreen() {
    if (screen == 1) _CountDown();
    if (_nameUser.isEmpty) _nameUser = _PhoneNumber;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Xin chào, $_nameUser! \n $_PhoneNumber",
            style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 17,
                fontStyle: FontStyle.normal),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          onChanged: (value) {
            setState(() {
              _otpInput = value;
            });
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "● ● ● ● ● ●",
            hintStyle: TextStyle(
                wordSpacing: 2, color: Color.fromARGB(255, 220, 220, 220)),
            labelText: "Nhập mật khẩu OTP",
            labelStyle: TextStyle(
              color: Color.fromARGB(255, 168, 167, 167),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 20,
              letterSpacing: 0.1,
              fontFamily: "Inter",
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 168, 167, 167), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: TextButton(
              style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
              onPressed: () {
                if (_timeleft == 0) {
                  _timeleft = 60;
                }
              },
              child: Row(
                children: [
                  Text("Gửi lại OTP ", style: style),
                  Text(_timeleft.toString() + "s", style: style)
                ],
              ),
            )),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  screen = 0;
                });
              },
              child: Text(
                "Đổi SĐT",
                style: style,
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SizedBox(
      child: Stack(
        children: [
          GetBuilder<AuthenticationController>(
              builder: (controller) => SizedBox(
                  height: height,
                  width: width,
                  child: Stack(children: [
                    Positioned(
                        top: -206,
                        left: -52,
                        child: Container(
                            width: 472,
                            height: 472,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color.fromRGBO(255, 31, 25, 1),
                                    Color.fromRGBO(255, 139, 68, 1)
                                  ]),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(472, 472)),
                            ))),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(left: 30, top: 26),
                            width: 183,
                            height: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/app_logo.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                    Center(
                        child: Container(
                      width: 380,
                      height: 595,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromRGBO(244, 244, 244, 1),
                        borderRadius: BorderRadius.all(Radius.circular(34)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(181, 181, 226, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 5)
                        ],
                      ),
                    )),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: height / 4,
                              left: width / 8,
                              right: width / 8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                screen == 0
                                    ? _enterPhoneNumber()
                                    : _otpScreen(),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ToggleSwitch(
                                      customTextStyles: [
                                        TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600)
                                      ],
                                      minWidth: 70.0,
                                      minHeight: 30,
                                      cornerRadius: 20.0,
                                      activeBgColors: [
                                        [Color.fromARGB(255, 255, 255, 255)],
                                        [Color.fromARGB(255, 255, 255, 255)]
                                      ],
                                      activeFgColor: Colors.white,
                                      inactiveBgColor:
                                          Color.fromARGB(255, 217, 217, 217),
                                      inactiveFgColor: Colors.white,
                                      totalSwitches: 2,
                                      labels: ['Vie', 'Eng'],
                                      radiusStyle: true,
                                      changeOnTap: true,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (screen == 0) if (_PhoneNumber
                                                .isEmpty ||
                                            _PhoneNumber.length < 10) {
                                          setState(() {
                                            _errorPhoneInput =
                                                'SĐT hiện không đúng, vui lòng nhập lại!';
                                          });
                                        } else {
                                          setState(() {
                                            _errorPhoneInput = '';
                                            verifyPhone();
                                            screen = 1;
                                            _timeleft = 60;
                                          });
                                        }
                                        if (screen == 1) if (_otpInput.length >=
                                            6) {
                                          verifyOTP();
                                        }
                                      },
                                      child: Container(
                                          height: 60,
                                          width: width,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              bottom: height / 12),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.topLeft,
                                                colors: [
                                                  Color.fromRGBO(
                                                      255, 139, 68, 1),
                                                  Color.fromRGBO(255, 31, 25, 1)
                                                ]),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Center(
                                              child: Text("Tiếp tục",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontFamily: 'Inter',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  )))),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ]),
                        ))
                  ])))
        ],
      ),
    ));
  }
}
