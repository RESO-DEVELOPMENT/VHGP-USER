import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 50,
                width: 50,
                color: const Color.fromRGBO(204, 204, 204, 1),
                child: Center(
                    child: FaIcon(
                  faIcon,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                )),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontSize: 15,
                    )),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
