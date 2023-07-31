import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/home_controller.dart';
import 'package:vinhome_user/models/response/menu_mode3s.dart';

import '../common/color.dart';

class SchedulerWeek extends StatelessWidget {
  final MenuMode3 menuMode3;
  final int index;
  const SchedulerWeek({
    Key? key,
    required this.menuMode3,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String day = "2";
    switch (menuMode3.dayOfWeek) {
      case "Tuesday":
        day = "T3";
        break;
      case ("Wednesday"):
        day = "T4";
        break;
      case ("Thursday"):
        day = "T5";
        break;
      case ("Friday"):
        day = "T6";
        break;
      case ("Saturday"):
        day = "T7";
        break;
      case ("Sunday"):
        day = "CN";
        break;
      default:
        day = "T2";
    }

    return GetBuilder<HomeController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.getMenuMode3s(menuMode3.id, '');
          controller.changeChoiceIndexDayFiltter(index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.08,
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
                colors: index == controller.choiceIndexDayFiltter
                    ? [primary, primary2]
                    : [
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 255, 255, 255)
                      ],
              )),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: index == controller.choiceIndexDayFiltter
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
              Text(
                "${menuMode3.dayFilter.day}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: index == controller.choiceIndexDayFiltter
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
