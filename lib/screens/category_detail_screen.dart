import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/home_controller.dart';
import 'package:vinhome_user/controllers/address_controller.dart';
import 'package:vinhome_user/controllers/product_controller.dart';
import 'package:vinhome_user/controllers/store_controller.dart';
import 'package:vinhome_user/utils/screen_utils.dart';
import 'package:vinhome_user/widgets/empty_food.dart';
import 'package:vinhome_user/widgets/loading.dart';
import 'package:vinhome_user/widgets/tab_title_uncount.dart';

import '../common/color.dart';
import '../models/offer.dart';
import '../models/response/store_response.dart';
import '../widgets/cart_button.dart';
import '../widgets/category_tab.dart';
import '../widgets/deal_card.dart';
import '../widgets/delivery.widget.dart';
import '../widgets/product_list.dart';
import '../widgets/tab_title.dart';
import 'deals_list_screen.dart';
import 'routes/routes.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String TITLE_MODE2 = "Hôm Nay Nấu Gì?";

  final String SUB_TITLE_MODE1 =
      "Gọi là có - nhận đơn và xử lý giao hàng ngay.";
  final String SUB_TITLE_MODE2 = "Thực phẩm tươi sống giao ngay trong ngày.";

  final String TITLE_MODE3 = "Đồ Ăn Cho Cả Tuần";
  final String SUB_TITLE_MODE3 = "Đặt hàng và giao hàng trong 3 - 5 ngày";

  final HomeController controller = Get.find<HomeController>();
  final StoreController storeController = Get.find<StoreController>();
  final AddressController addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DeliveryWidget(
          addressController: addressController,
          isHome: false,
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => controller.isLoading
            ? loading()
            : SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    _buildOfferCarousel(context),
                    if (Get.arguments == 1 || Get.arguments == 2)
                      _buildCategories(),
                    _getModel(context),
                  ],
                ),
              ),
      ),
      floatingActionButton: CartButton(),
    );
  }

  Loading loading() {
    return Loading(
      mode: Get.arguments,
    );
  }

  SizedBox _getModel(BuildContext context) {
    SizedBox build = const SizedBox();

    switch (controller.modeId) {
      case 1:
        build = _getStores(context);
        break;
      case 2:
        build = _buildProducts();
        break;
      case 3:
        build = _buildMode3(context);
        break;
      default:
        build = SizedBox();
    }
    return build;
  }

  SizedBox _getStores(BuildContext context) {
    return SizedBox(
      child: GetBuilder<HomeController>(
        builder: (controller) => controller.isLoading
            ? Loading(
                mode: -1,
              )
            : Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, parentIndex) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabTitleUnCount(
                          title: controller
                              .storeCategoriesResponseList[parentIndex].name,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5.1,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => DealCard(
                              onTap: () {
                                storeController.getStoreById(
                                    controller
                                        .storeCategoriesResponseList[index]
                                        .listStores[index]
                                        .id,
                                    false);
                                Get.toNamed(Routes.store);
                              },
                              isHorizontalScrolling: true,
                              storeResponse: StoreResponse(
                                  id: controller
                                      .storeCategoriesResponseList[parentIndex]
                                      .listStores[index]
                                      .id,
                                  building: controller
                                      .storeCategoriesResponseList[parentIndex]
                                      .listStores[index]
                                      .building,
                                  image: controller
                                      .storeCategoriesResponseList[parentIndex]
                                      .listStores[index]
                                      .image,
                                  name: controller
                                      .storeCategoriesResponseList[parentIndex]
                                      .listStores[index]
                                      .name,
                                  storeCategory: controller
                                      .storeCategoriesResponseList[parentIndex]
                                      .listStores[index]
                                      .storeCategory),
                            ),
                            itemCount: controller
                                .storeCategoriesResponseList[parentIndex]
                                .listStores
                                .length,
                          ),
                        ),
                      ],
                    ),
                    itemCount: controller.storeCategoriesResponseList.length,
                  ),
                  DealsList(),
                ],
              ),
      ),
    );
  }

  SizedBox _buildProducts() {
    final ProductController productController = Get.find<ProductController>();
    return SizedBox(
      child: GetBuilder<HomeController>(
        builder: (controller) => controller.isLoading
            ? Loading(
                mode: Get.arguments,
              )
            : ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.listCategoryStoreInMenusFiltered.length,
                itemBuilder: (context, parentIndex) => Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    children: [
                      TabTitleUnCount(
                        title: controller
                            .listCategoryStoreInMenusFiltered[parentIndex].name,
                      ),
                      SizedBox(
                          height: 253,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller
                                .listCategoryStoreInMenusFiltered[parentIndex]
                                .listProducts
                                .length,
                            itemBuilder: (context, index) => ProductList(
                                onTap: () {
                                  productController.getProductDetail(controller
                                      .listCategoryStoreInMenusFiltered[
                                          parentIndex]
                                      .listProducts[index]
                                      .id);
                                  Get.toNamed(Routes.productDetail);
                                },
                                product: controller
                                    .listCategoryStoreInMenusFiltered[
                                        parentIndex]
                                    .listProducts[index]),
                          )),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildCategories() {
    var categoryList = [];
    switch (Get.arguments) {
      case 1:
        categoryList = controller.cateroiesResponse.listCategoryInMenus;
        break;
      case 2:
        categoryList =
            controller.categoriesModeResponse.listCategoryStoreInMenus;
        break;
      default:
      // _buildProducts();
    }
    return CategoryTab(
      categories: categoryList,
      isHome: false,
    );
  }

  Column _buildTitle() {
    String title = "";
    String subTitle = "";

    switch (controller.modeId) {
      case 1:
        title = controller.cateroiesResponse.name;
        subTitle = SUB_TITLE_MODE1;
        break;
      case 2:
        title = TITLE_MODE2;
        subTitle = SUB_TITLE_MODE2;
        break;
      case 3:
        title = TITLE_MODE3;
        subTitle = SUB_TITLE_MODE3;
        break;
      default:
        title = "HOME";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(
              16,
            ),
            vertical: getProportionateScreenWidth(4),
          ),
          child: Text(subTitle, style: const TextStyle(color: kGreyShade1)),
        ),
        TabTitle(
          title: title,
          endTime:
              Get.arguments == 1 ? controller.cateroiesResponse.endTime : -1,
        ),
      ],
    );
  }

  Widget _buildOfferCarousel(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: CarouselSlider.builder(
        carouselController: controller.carouselController,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1,
          aspectRatio: 1,
          initialPage: 0,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          // onPageChanged: (index, reason) => controller.changeBanner(index),
        ),
        itemCount: controller.activeOffers.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            _buildOffer(controller.activeOffers[itemIndex]),
      ),
    );
  }

  Widget _buildOffer(Offer offer) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: CachedNetworkImage(
        width: double.infinity,
        imageUrl: offer.image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildOfferIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<HomeController>(
          builder: (controller) => SizedBox(
            height: 8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Obx(
                () => AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Get.isDarkMode ? Colors.white : Colors.blueGrey)
                          .withOpacity(
                              controller.currentBanner == index ? 0.9 : 0.2)),
                ),
              ),
              itemCount: controller.listCategoryStoreInMenusFiltered.length,
            ),
          ),
        ),
      ],
    );
  }
}

SizedBox _buildMode3(context) {
  final StoreController storeController = Get.find<StoreController>();

  return SizedBox(
    child: GetBuilder<HomeController>(
      builder: (controller) => controller.isLoading
          ? Loading(
              mode: Get.arguments,
            )
          : controller.listMode3.isEmpty
              ? EmptyFood()
              : ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.listMode3.length,
                  itemBuilder: (context, parentIndex) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        TabTitleUnCount(
                          title: controller.listMode3[parentIndex].name,
                          actionText: 'Xem thêm',
                          seeAll: () {
                            controller.getMenuMode3s(
                                controller.listMode3[parentIndex].id, '');
                            Get.toNamed(Routes.fillterMode3);
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller
                                .listMode3[parentIndex].listStores.length,
                            itemBuilder: (context, index) => DealCard(
                              onTap: () {
                                controller.deliveryTimeMode3 =
                                    controller.listMode3[parentIndex].name;
                                controller.getMenuMode(3).then((value) {
                                  Get.toNamed(Routes.store);
                                  storeController.getStoreById(
                                      controller.listMode3[parentIndex]
                                          .listStores[index].id,
                                      true);
                                });
                              },
                              isHorizontalScrolling: true,
                              storeResponse: null,
                              listStore: controller
                                  .listMode3[parentIndex].listStores[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    ),
  );
}
