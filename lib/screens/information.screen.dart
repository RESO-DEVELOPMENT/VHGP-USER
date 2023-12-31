import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/color.dart';
import '../controllers/user_controller.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen({Key? key}) : super(key: key);
  static late final SharedPreferences prefs;

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final _formKey = GlobalKey<FormState>();

  final UserController userController = Get.find<UserController>();

  String pass = '';

  void getPass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    pass = prefs.getString('password') ?? '';
    userController.textPasswordController.clear();
    userController.textPasswordOldController.clear();
    userController.textConfirmPasswordController.clear();
    print(pass);
  }

  @override
  void initState() {
    // TODO: implement initState
    getPass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Thông tin cá nhân',
      )),
      body: GetBuilder<UserController>(
        builder: (controller) => SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tên",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: userController.textNameController,
                        decoration: InputDecoration(
                          hintText: "Tên",
                          border: const OutlineInputBorder(),
                          errorText:
                              userController.textNameController.text.isBlank ==
                                      true
                                  ? "Vui lòng nhập tên"
                                  : null,
                          errorStyle: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) => InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (_formKey.currentState!.validate()) {
            userController.updateUserName();
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
          child: const Text(
            'Xác nhận',
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
}
