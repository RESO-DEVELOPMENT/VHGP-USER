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
          padding: const EdgeInsets.all(4),
          child: Icon(
            faIcon,
            color: Get.theme.primaryColor,
            size: 16,
          ),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
