import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinhome_user/controllers/user_controller.dart';
import 'package:vinhome_user/screens/routes/routes.dart';
import '../../common/color.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/image_container.dart';
import '../models/response/user.dart';
import 'package:get/get.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late User user = User(
      id: '', password: '', name: '', roleId: '', status: '', imageUrl: '');
  final UserController userController = Get.find<UserController>();
  late SharedPreferences prefs;
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      String strUser = prefs.getString("user") ?? '';
      if (strUser != '') {
        user = userFromJson(strUser);
        userController.user = user;
        userController.textNameController.text = user.name;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Thông tin',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (controller) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16.0),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                ImageContainer(),
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                Text(controller.user.name,
                    style: Theme.of(context).textTheme.titleLarge),
                Text(controller.user.id,
                    style: Theme.of(context).textTheme.titleMedium),
                Divider(
                  height: getProportionateScreenHeight(32.0),
                ),
                ProfileCard(
                  image: 'assets/images/profile_user.png',
                  color: kAccentGreen,
                  title: 'Thông tin cá nhân',
                  tapHandler: () => Get.toNamed(Routes.information),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                ProfileCard(
                  image: 'assets/images/lock.png',
                  color: Color.fromARGB(255, 227, 226, 226),
                  title: 'Đổi mật khẩu',
                  tapHandler: () => Get.toNamed(Routes.changePass),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                ProfileCard(
                  image: 'assets/images/map_user.png',
                  color: kAccentTosca,
                  title: 'Địa chỉ',
                  tapHandler: () => Get.toNamed(Routes.address),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                ),
                ProfileCard(
                  image: 'assets/images/arrow_user.png',
                  color: kAccentRed,
                  title: 'Đăng xuất',
                  tapHandler: () {
                    prefs.clear();
                    Get.offAllNamed(Routes.login);
                  },
                ),
                Spacer(),
                SizedBox(
                  height: getProportionateScreenHeight(8.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    this.image,
    this.title,
    required this.tapHandler,
    this.color,
  }) : super(key: key);

  final String? image;
  final String? title;
  final VoidCallback tapHandler;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapHandler,
      child: Container(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(8.0),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              color: kShadowColor.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(8.0),
              ),
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(8.0),
                  ),
                ),
              ),
              child: Image.asset(
                image!,
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(8.0),
            ),
            Expanded(
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
