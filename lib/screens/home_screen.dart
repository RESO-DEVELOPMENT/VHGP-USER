import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vinhome_user/controllers/address_controller.dart';
import 'package:vinhome_user/controllers/home_controller.dart';
import 'package:vinhome_user/controllers/store_controller.dart';
import 'package:vinhome_user/models/category_model.dart';
import 'package:vinhome_user/screens/routes/routes.dart';
import 'package:vinhome_user/widgets/loading.dart';
import 'package:vinhome_user/widgets/tab_title_uncount.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../common/color.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/deal_card.dart';
import '../models/offer.dart';
import '../widgets/category_tab.dart';
import '../widgets/delivery.widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();
  final StoreController storeController = Get.find<StoreController>();
  final AddressController addressController = Get.find<AddressController>();

  @override
  void initState() {
    super.initState();
    controller.getMenuMode(2);
    controller.getStoreCategoriesMode('2', true);
    addressController.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return GetBuilder<HomeController>(
      builder: (controller) => controller.isLoading
          ? Loading(mode: -1)
          : Scaffold(
              appBar: AppBar(
                toolbarHeight: 100,
                title: DeliveryWidget(
                    addressController: addressController, isHome: true),
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: false,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        primary,
                        primary2,
                      ])),
                ),
              ),
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Stack(
                  children: [
                    Container(
                      height: ScreenUtils.screenHeight,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            primary2,
                            primary,
                          ])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/home-removebg.png',
                                  height: 160,
                                  width: 150,
                                ),
                                SizedBox(
                                  width: ScreenUtils.screenWidth! / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "VNGP.NET",
                                        style: TextStyle(
                                            color: kTextColorForth,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      Text(
                                          "Dịch vụ tiện ích giao hàng tận nơi cho cư dân",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(color: Colors.white)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      top: ScreenUtils.screenHeight! * 0.2,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCategories(context),
                              // _buildDealByCategories(),
                              _buildOfferCarousel(context),
                              _getStores(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Padding _buildDealByCategories() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GetBuilder<HomeController>(
        builder: (controller) => controller.isLoading
            ? Container()
            : CategoryTab(
                categories: controller.listCategoryStoreInMenusFilteredHome,
                isHome: true),
      ),
    );
  }

  Column _getStores(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TabTitleUnCount(
          title: 'Quán ngon gần bạn',
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4.1,
          child: GetBuilder<StoreController>(
            builder: (storeController) => ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => DealCard(
                onTap: () {
                  controller.getMenuMode(1).then((value) {
                    Get.toNamed(Routes.store);
                    storeController.getStoreById(
                        storeController.storeResponses[index].id, true);
                  });
                },
                isHorizontalScrolling: true,
                storeResponse: storeController.storeResponses[index],
                listStore: null,
              ),
              itemCount: storeController.storeResponses.length,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildOfferCarousel(context) {
  Widget _buildCategories(BuildContext theme) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(theme).size.width * 0.028),
      child: SizedBox(
        height: 120,
        width: MediaQuery.of(theme).size.width,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return _buildCategory(controller.categories[index], index, theme);
          },
        ),
      ),
    );
  }

  Widget _buildOfferCarousel(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
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

  Widget _buildCategory(CategoryModel category, index, theme) {
    return ZoomTapAnimation(
      beginDuration: const Duration(milliseconds: 300),
      endDuration: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: category.function,
        child: Card(
          elevation: 2,
          surfaceTintColor: Colors.grey,
          margin: EdgeInsets.only(
              right: controller.categories.length - 1 == index ? 0 : 8),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(theme).size.width * 0.3,
                height: MediaQuery.of(theme).size.height * 0.3,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      category.image,
                      height: MediaQuery.of(theme).size.height * 0.045,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Text(category.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(theme).textTheme.titleMedium),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
