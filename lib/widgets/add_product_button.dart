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
    return SizedBox(
      height: 36,
      child: GetBuilder<CartController>(
        builder: (controller) => controller.cart.orderDetail
                    .firstWhere(
                      (element) => element.productId == productId,
                      orElse: () => OrderDetail(
                          productId: 'productId', quantity: '0', price: 1),
                    )
                    .quantity !=
                '0'
            ? Card(
                margin: EdgeInsets.all(2),
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () =>
                            controller.subtractProduct(product, isCartScreen),
                        icon: const Icon(
                          Icons.remove,
                          size: 20,
                          color: primary,
                        )),
                    Text(
                        controller.cart.orderDetail
                            .firstWhere(
                              (element) => element.productId == productId,
                            )
                            .quantity,
                        style: Get.textTheme.bodyLarge),
                    IconButton(
                      onPressed: () {
                        controller.addProduct(product, isCartScreen, context);
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 20,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              )
            : ElevatedButton(
                onPressed: () =>
                    controller.addProduct(product, isCartScreen, context),
                child: Text(
                  'Thêm',
                ),
              ),
      ),
    );
  }
}
