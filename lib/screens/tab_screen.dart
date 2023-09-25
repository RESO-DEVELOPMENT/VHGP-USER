import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/cart_controller.dart';
import 'package:vinhome_user/controllers/address_controller.dart';
import 'package:vinhome_user/controllers/tab_app_controller.dart';
import 'package:vinhome_user/screens/cart_screen.dart';
import '../../widgets/custom_nav_bar.dart';
import '../widgets/cart_button.dart';
import 'history_screen.dart';
import 'home_screen.dart';
import 'user_screen.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tabScreen';

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final AddressController addressController = Get.find<AddressController>();
  final CartController cartController = Get.find<CartController>();

  final TabAppController tabAppController = Get.find<TabAppController>();

  @override
  Widget build(BuildContext context) {
    List<Map<String, Widget>> pages = [
      {
        'widget': HomeScreen(),
      },
      {
        'widget': CartScreen(),
      },
      {
        'widget': HistoryScreen(),
      },
      {
        'widget': UserScreen(),
      },
    ];
    return Scaffold(
      body: pages[tabAppController.curTab]['widget']!,
      bottomNavigationBar: CustomNavBar((index) {
        setState(() {
          tabAppController.curTab = index;
        });
      }, tabAppController.curTab),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: Get.theme.primaryColor.withOpacity(0.3),
              offset: const Offset(
                0.0,
                5.0,
              ),
              blurRadius: 10,
              spreadRadius: 2,
            ), //BoxShadow
            //BoxShadow
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            // _setPage(2);
          },
          child: GetBuilder<CartController>(
            builder: (cartController) => Stack(
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                      backgroundColor: Get.theme.primaryColor,
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
