import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/home_controller.dart';

import '../common/color.dart';
import '../models/response/menu_mode3s.dart';

class FilterByCategory extends StatelessWidget {
  final CategoryInMenuView categoryInMenuView;
  final int index;
  const FilterByCategory({
    Key? key,
    required this.categoryInMenuView,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.changeChoideIndexCategoryByView(index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.045,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: index == controller.choideIndexCategoryByView
                  ? [primary, primary2]
                  : [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255)
                    ],
            ),
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              categoryInMenuView.name,
              style: TextStyle(
                color: index == controller.choideIndexCategoryByView
                    ? Color.fromARGB(255, 255, 255, 255)
                    : primary,
              ),
              textAlign: TextAlign.center,
            ),
          )),
        ),
      ),
    );
  }
}
