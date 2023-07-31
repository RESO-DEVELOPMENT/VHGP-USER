import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/color.dart';
import '../controllers/cart_controller.dart';

class CartAddProduct extends StatefulWidget {
  const CartAddProduct(
      {Key? key, required this.product, required this.isCartScreen})
      : super(key: key);
  final dynamic product;
  final bool isCartScreen;

  @override
  State<CartAddProduct> createState() => _CartAddProductState();
}

class _CartAddProductState extends State<CartAddProduct> {
  final CartController cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SizedBox(
        height: 35,
        // width: 120,
        child: cartController.quantity != 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => cartController.subtract(),
                      icon: const Icon(
                        Icons.remove,
                        size: 15,
                        color: primary,
                      )),
                  Text(cartController.quantity.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      cartController.add();
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 15,
                      color: primary,
                    ),
                  ),
                ],
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 170, 76, .2),
                ),
                onPressed: () => cartController.add(),
                child: const Text(
                  'Thêm',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 170, 76, 1),
                      fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
