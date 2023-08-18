import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/home_controller.dart';
import 'package:vinhome_user/controllers/product_controller.dart';
import 'package:vinhome_user/widgets/cart_button.dart';

import '../common/color.dart';
import '../models/response/categories_response.dart';
import '../widgets/empty_food.dart';
import 'product_list_screen.dart';

class ProductCategoryScreen extends StatefulWidget {
  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  final ProductController productController = Get.find<ProductController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    productController.setTile(Get.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<ProductController>(
          builder: (controller) => Text(
            productController.titleScreen,
          ),
        ),
        centerTitle: false,
        backgroundColor: grey,
      ),
      body: GetBuilder<ProductController>(
        builder: (controller) => productController.isLoading
            ? Container()
            : Column(
                children: [
                  _buildCategories(context),
                  productController.productByCategory.listProducts.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: EmptyFood(),
                        )
                      : SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1.4,
                            child: DealsListButtonScreen(
                              listProducts: productController
                                  .productByCategory.listProducts,
                              isCategoryDetail: true,
                            ),
                          ),
                        ),
                ],
              ),
      ),
      floatingActionButton: CartButton(),
    );
  }

  Widget _buildCategories(BuildContext theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 36,
        width: MediaQuery.of(theme).size.width,
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => showCupertinoModalPopup(
                context: context,
                builder: (context) => buildFilterProduct(index),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(productController.titles[index]),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildFilterProduct(int index) {
    List<String> listTitle = [];
    CateroiesResponse? cateroiesResponse;
    if (index == 0) {
      listTitle = productController.listFast;
    } else if (index == 1) {
      listTitle = productController.listFollow;
    } else {
      try {
        cateroiesResponse = homeController.cateroiesResponse;
      } catch (e) {
        cateroiesResponse = CateroiesResponse(
            id: '',
            name: 'name',
            startTime: 1,
            endTime: 1,
            listCategoryInMenus: []);
      }
    }
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 180,
      child: CupertinoPicker(
        backgroundColor: Colors.white,
        itemExtent: 64,
        onSelectedItemChanged: (value) => productController
            .filterProduct(cateroiesResponse!.listCategoryInMenus[value]),
        children: index == 2
            ? cateroiesResponse!.listCategoryInMenus
                .map(
                  (e) => Center(
                    child: Text(e.name),
                  ),
                )
                .toList()
            : listTitle
                .map(
                  (e) => Center(
                    child: Text(e),
                  ),
                )
                .toList(),
      ),
    );
  }
}
