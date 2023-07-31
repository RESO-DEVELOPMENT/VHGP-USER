import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/models/cart.dart';

import '../common/color.dart';
import '../controllers/cart_controller.dart';

class AddProduct extends StatelessWidget {
  const AddProduct(
      {Key? key, required this.product, required this.isCartScreen})
      : super(key: key);
  final dynamic product;
  final bool isCartScreen;
  @override
  Widget build(BuildContext context) {
    String productId = isCartScreen ? product.productId : product.id;
    return Card(
      elevation: 5,
      child: SizedBox(
        height: 35,
        // width: 120,
        child: GetBuilder<CartController>(
          builder: (controller) => controller.cart.orderDetail
                      .firstWhere(
                        (element) => element.productId == productId,
                        orElse: () => OrderDetail(
                            productId: 'productId', quantity: '0', price: 1),
                      )
                      .quantity !=
                  '0'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () =>
                            controller.subtractProduct(product, isCartScreen),
                        icon: const Icon(
                          Icons.remove,
                          size: 15,
                          color: primary,
                        )),
                    Text(
                        controller.cart.orderDetail
                            .firstWhere(
                              (element) => element.productId == productId,
                            )
                            .quantity,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () {
                        controller.addProduct(product, isCartScreen, context);
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
                  onPressed: () =>
                      controller.addProduct(product, isCartScreen, context),
                  child: const Text(
                    'Thêm',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 170, 76, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
        ),
      ),
    );
  }
}
