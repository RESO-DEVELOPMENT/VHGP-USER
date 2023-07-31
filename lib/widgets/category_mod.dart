import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/widgets/type_card.dart';

import '../controllers/home_controller.dart';
import '../models/category.dart';
import '../screens/routes/routes.dart';
import '../utils/screen_utils.dart';

class CategoriesMod extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      Category(
          'Gọi món',
          'assets/images/hamburger.png',
          () => {
                controller.getCategories('2'),
                Get.toNamed(Routes.categoryDetail),
              }),
      Category(
          'Giao hàng',
          'assets/images/groceries.png',
          () => {
                controller.getCategories('2'),
                Get.toNamed(Routes.mode1),
              }),
      Category(
          'Đặt hàng',
          'assets/images/food-delivery.png',
          () => {
                controller.getCategories('3'),
                Get.toNamed(Routes.mode1),
              }),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          categories.length,
          (index) => TypeyCard(categories[index]),
        ),
      ),
    );
  }
}
