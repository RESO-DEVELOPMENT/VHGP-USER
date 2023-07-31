import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinhome_user/controllers/apis/api_path.dart';
import 'package:vinhome_user/controllers/authentication_controller.dart';
import 'package:vinhome_user/models/response/user.dart';
import 'package:vinhome_user/screens/routes/routes.dart';
import 'package:vinhome_user/utils/ResponseUtil.dart';

class UserController extends GetxController {
  User user = User(id: '', name: '', roleId: '', imageUrl: '');
  var isSubmit = false;

  TextEditingController textNameController = TextEditingController();
  TextEditingController textUserNameController = TextEditingController();
  TextEditingController textPasswordOldController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  TextEditingController textConfirmPasswordController = TextEditingController();

  Future<void> updatePass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String _oldPassword = prefs.getString('password') ?? '';
    String password = textPasswordController.text;
    if (password.length < 6 ||
        password != textConfirmPasswordController.text ||
        _oldPassword == textPasswordController.text ||
        _oldPassword != textPasswordOldController.text) {
      update();
      return;
    }

    user.password = _oldPassword;
    Map<String, String> params = {
      "id": user.id,
      "pass": _oldPassword,
      "newPass": password
    };
    await ResponseUtil.putQueryParamsMapping(
            params, ApiPath.USER + "/change-pass/")
        .then((value) {
      prefs.setString('password', textPasswordController.text);
      update();
      Get.back();
    });
  }

  Future<void> updateUserInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = textNameController.text;
    // print("old" + _oldPassword);
    if (name == "") {
      update();
      return;
    }

    String strUser = prefs.getString("user") ?? '';
    if (strUser != '') {
      user = userFromJson(strUser);
      user.name = name;

      await ResponseUtil.putMapping(ApiPath.USER, userToJsonUpdate(user))
          .then((value) {
        print(ApiPath.USER);
        print(userToJsonUpdate(user));
        prefs.setString('user', userToJson(user));
        print(value.status);
        update();
        Get.back();
      });
    }
  }

  Future<void> updateUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = textNameController.text;
    // print("old" + _oldPassword);
    if (name == "") {
      update();
      return;
    }

    String strUser = prefs.getString("user") ?? '';
    if (strUser != '') {
      user = userFromJson(strUser);
      user.name = name;

      await ResponseUtil.putMapping(ApiPath.USER, userToJsonUpdateName(user))
          .then((value) {
        print(ApiPath.USER);
        print(userToJsonUpdate(user));
        prefs.setString('user', userToJson(user));
        print(value.status);
        update();
        Get.back();
      });
    }
  }

  Future<void> createUserInformation() async {
    isSubmit = true;
    String userName = textUserNameController.text;
    String name = textNameController.text;
    String password = textPasswordController.text;
    if (userName == "" ||
        name == "" ||
        password.length < 6 ||
        password != textConfirmPasswordController.text) {
      update();
      return;
    }

    Map<String, String> params = {
      "username": userName,
      "pass": password,
      "name": name
    };
    ResponseUtil.postQueryParamsMapping(params, ApiPath.USER).then((value) {
      if (value.status == 200) {
        isSubmit = false;
        Get.offAllNamed(Routes.login);
      }
      update();
    });
  }

  Future pickImage(bool isCamera) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String _oldPassword = prefs.getString('password') ?? '';
    try {
      final XFile? image;
      if (!isCamera) {
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        image = await ImagePicker().pickImage(source: ImageSource.camera);
      }
      if (image != null) {
        final imageTemporary = File(image.path);
        print(imageTemporary);
        var bytes = File(imageTemporary!.path).readAsBytesSync();
        var img64 = base64Encode(bytes);

        User updateUser = user;
        updateUser.imageUrl = img64;
        print(userToJsonUpdate(updateUser));
        await ResponseUtil.putMapping(
                ApiPath.USER, userToJsonUpdate(updateUser))
            .then((value) {
          print(value.status);
          login(user.id, _oldPassword);
          Get.back();
          update();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> login(String id, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> params = {"id": id, "pass": password};
    ResponseUtil.getMapping(path: ApiPath.LOGIN, queryParams: params)
        .then((value) {
      if (value.status == 200) {
        prefs.setString("user", value.body);
        prefs.setString("password", password);
        print("loginloginloginlogin");
        print(value.body);
        user = userFromJson(value.body);
      }
      update();
    });
  }
}
