import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/home_controller.dart';

import '../utils/screen_utils.dart';
import 'category_card.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({Key? key, required this.categories, required this.isHome})
      : super(key: key);

  final dynamic categories;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: categories.length < 3
            ? 100
            : MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: GridView(
            scrollDirection:
                categories.length < 3 ? Axis.vertical : Axis.horizontal,
            shrinkWrap: true,
            controller: homeController.scrollController,
            physics: isHome || categories.length < 3
                ? const NeverScrollableScrollPhysics()
                : const ClampingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.19,
              crossAxisSpacing: getProportionateScreenWidth(8),
            ),
            children: List.generate(
              categories.length,
              (index) => CategoryCard(categories[index],
                  isHome && index == categories.length - 1 ? true : false),
            ),
          ),
        ),
      ),
    );
  }
}
