import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class UserInformation extends StatelessWidget {
  const UserInformation(
      {Key? key,
      required this.cartController,
      required this.label,
      required this.value,
      required this.faIcon})
      : super(key: key);

  final CartController cartController;
  final String label;
  final String value;
  final IconData faIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            faIcon,
            size: 24,
          ),
        ),
        // ClipRRect(
        //     borderRadius: BorderRadius.circular(8),
        //     child: Container(
        //       height: 40,
        //       width: 40,
        //       color: const Color.fromRGBO(204, 204, 204, 1),
        //       child: Center(
        //           child: FaIcon(
        //         faIcon,
        //         color: const Color.fromRGBO(255, 255, 255, 1),
        //       )),
        //     )),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.titleMedium,
        ),
      ],
    );
  }
}
