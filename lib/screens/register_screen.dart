import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/color.dart';
import '../controllers/user_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Đăng kí tài khoản',
        style: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
        ),
      )),
      body: GetBuilder<UserController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tài khoản",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: userController.textUserNameController,
                      decoration: InputDecoration(
                        hintText: "Nhập tài khoản",
                        border: const OutlineInputBorder(),
                        errorText: userController.isSubmit == true &&
                                userController
                                        .textUserNameController.text.isBlank ==
                                    true
                            ? "Vui lòng nhập tài khoản"
                            : null,
                        errorStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Tên",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: userController.textNameController,
                      decoration: InputDecoration(
                        hintText: "Tên",
                        border: const OutlineInputBorder(),
                        errorText: userController.isSubmit == true &&
                                userController
                                        .textNameController.text.isBlank ==
                                    true
                            ? "Vui lòng nhập tên"
                            : null,
                        errorStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Mật khẩu",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: userController.textPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Mật khẩu",
                        border: const OutlineInputBorder(),
                        errorText: userController.isSubmit == true &&
                                userController
                                        .textPasswordController.text.length <
                                    6
                            ? "Mật khẩu tối thiểu 6 ký tự"
                            : null,
                        errorStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Xác nhận mật khẩu",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller:
                              userController.textConfirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Xác nhận mật khẩu",
                            border: const OutlineInputBorder(),
                            errorText: userController
                                            .textConfirmPasswordController
                                            .text !=
                                        userController
                                            .textPasswordController.text &&
                                    userController.textConfirmPasswordController
                                        .text.isNotEmpty
                                ? "Mật khẩu không khớp"
                                : null,
                            errorStyle: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) => InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            userController.createUserInformation();
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
