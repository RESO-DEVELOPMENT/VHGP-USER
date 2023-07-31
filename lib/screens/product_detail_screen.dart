import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/product_controller.dart';
import 'package:vinhome_user/controllers/store_controller.dart';
import 'package:vinhome_user/screens/routes/routes.dart';
import 'package:vinhome_user/utils/money_format.dart';
import 'package:vinhome_user/widgets/cart_button.dart';

import '../common/color.dart';
import '../widgets/add_product_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  final StoreController storeController = Get.find<StoreController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết sản phẩm',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: GetBuilder<ProductController>(
        builder: (controller) => controller.isLoading
            ? Container()
            : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 250,
                        child: CachedNetworkImage(
                          imageUrl: productController.productResponse.image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          productController.productResponse.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viCurrency.format(
                                  productController.productResponse.pricePerPack),
                              style:
                                  const TextStyle(fontSize: 24, color: primary),
                            ),
                            Text(productController
                                .productResponse.packDescription),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'GIAO NHANH 30 PHÚT',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ),
                      const Divider(thickness: 0.8),
                      GestureDetector(
                        onTap: () {
                          storeController.getStoreById(
                              controller.productResponse.storeId, false);
                          Get.toNamed(Routes.store);
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              height: 75,
                              child: CachedNetworkImage(
                                height: 75,
                                width: 120,
                                imageUrl:
                                    productController.productResponse.storeImage,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                  productController.productResponse.storeName,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 0.8),
                      SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 2,
                          child: AddProduct(
                            product: productController.productResponse,
                            isCartScreen: false,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Table(
                              children: [
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text('Loại Thực Phẩm:'),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text(
                                        productController
                                            .productResponse.productCategory,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ]),
                                const TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text('Đóng Gói:'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text('Không có',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text('Tối Thiểu:'),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text(
                                        productController.productResponse
                                                    .minimumQuantity ==
                                                0
                                            ? 'Không có'
                                            : '${productController.productResponse.minimumQuantity} ${productController.productResponse.unit}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ]),
                                TableRow(children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text('Tối Đa:'),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text(
                                        productController.productResponse
                                                    .maximumQuantity ==
                                                0
                                            ? 'Không có'
                                            : '${productController.productResponse.maximumQuantity} ${productController.productResponse.unit}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ]),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
            ),
      ),
      floatingActionButton: CartButton(),
    );
  }
}
