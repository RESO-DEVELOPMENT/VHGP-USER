import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/address_controller.dart';
import 'package:vinhome_user/controllers/cart_controller.dart';

import '../common/color.dart';
import '../screens/routes/routes.dart';

class CartButton extends StatelessWidget {
  CartButton({
    Key? key,
  }) : super(key: key);
  final AddressController addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) => controller.cart.orderDetail.isEmpty
          ? Container()
          : FittedBox(
              child: Stack(
                alignment: const Alignment(0.8, -0.8),
                children: [
                  FloatingActionButton(
                    // Your actual Fab
                    onPressed: () {
                      if (addressController.addressList.isEmpty) {
                        Get.toNamed(Routes.createAddress);
                      } else {
                        controller.getTotal();
                        Get.toNamed(Routes.cart);
                      }
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    backgroundColor: grey,
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: black,
                      size: 32,
                    ),
                  ),
                  Container(
                    // This is your Badge
                    constraints:
                        const BoxConstraints(minHeight: 20, minWidth: 20),
                    decoration: BoxDecoration(
                      // This controls the shadow
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 5,
                            color: Colors.black.withAlpha(50))
                      ],
                      borderRadius: BorderRadius.circular(8),
                      color:
                          Colors.red[600], // This would be color of the Badge
                    ),
                    // This is your Badge
                    child: Center(
                      child: Text(controller.cart.orderDetail.length.toString(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
