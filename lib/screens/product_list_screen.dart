import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/product_controller.dart';
import 'package:vinhome_user/screens/routes/routes.dart';
import 'package:vinhome_user/utils/money_format.dart';
import 'package:vinhome_user/widgets/add_product_button.dart';

import '../models/response/product_list.dart';

class DealsListButtonScreen extends StatelessWidget {
  final List<ListProduct> listProducts;
  final isCategoryDetail;

  const DealsListButtonScreen(
      {Key? key, required this.listProducts, required this.isCategoryDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return SingleChildScrollView(
      child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  productController.getProductDetail(listProducts[index].id);
                  Get.toNamed(Routes.productDetail);
                },
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: 80.0,
                          width: 80.0,
                          imageUrl: listProducts[index].image,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.1,
                                        child: Text(
                                          listProducts[index].name,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      viCurrency.format(
                                          listProducts[index].pricePerPack),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                                if (isCategoryDetail)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        listProducts[index].storeName,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.clip,
                                      ),
                                      Text(
                                        listProducts[index].packDes,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.33,
                                    child: AddProduct(
                                      product: listProducts[index],
                                      isCartScreen: false,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          separatorBuilder: (BuildContext context, int index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
          itemCount: listProducts.length),
    );
  }
}
