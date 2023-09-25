import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vinhome_user/controllers/home_controller.dart';
import 'package:vinhome_user/controllers/store_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/widgets/empty_food.dart';
import 'package:vinhome_user/widgets/loading.dart';

import '../../common/color.dart';
import '../widgets/cart_button.dart';
import '../widgets/tab_title_uncount.dart';
import 'product_list_screen.dart';

class StoreScreen extends StatelessWidget {
  final StoreController controller = Get.find<StoreController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    String deliveryTime = "Giao nhanh 30 phút";
    switch (homeController.modeId) {
      case 1:
        deliveryTime = "Giao nhanh 30 phút";
        break;
      case 2:
        deliveryTime = "Giao trong ngày";
        break;
      case 3:
        if (homeController.deliveryTimeMode3 == "") {
          deliveryTime = homeController
              .menuMode3.menuMode3S[homeController.choiceIndexDayFiltter].name;
          homeController.deliveryTimeMode3 = deliveryTime;
        } else {
          deliveryTime = homeController.deliveryTimeMode3;
        }

        break;
      default:
        deliveryTime = "Giao nhanh 30 phút";
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết cửa hàng',
          style: Get.textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: GetBuilder<StoreController>(
          builder: (controller) => controller.isLoading
              ? const Loading(mode: -1)
              : Stack(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.55,
                      child: CachedNetworkImage(
                        imageUrl: controller.storeDetail.image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.30,
                          left: 15,
                          right: 15),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.storeDetail.name,
                                      style: Get.textTheme.titleMedium),
                                  if (controller.storeDetail.description !=
                                      null)
                                    Text(
                                      controller.storeDetail.description!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  Wrap(
                                    spacing:
                                        5, // to apply margin in the main axis of the wrap
                                    runSpacing: 5,
                                    children: [
                                      Row(
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(
                                              Icons.location_on,
                                              color: primary,
                                            ),
                                          ),
                                          Text(controller.storeDetail.location),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Icon(
                                              Icons.access_time,
                                              color: primary,
                                            ),
                                          ),
                                          Text(
                                              'Giờ hoạt động ${controller.storeDetail.openTime} - ${controller.storeDetail.closeTime}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 4,
                                          right: 8,
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.clockRotateLeft,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(deliveryTime,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  0, 128, 0, 1))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.80,
                        ),
                        child: controller.storeDetail.listProducts.isEmpty
                            ? Center(
                                child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30.0),
                                child: EmptyFood(),
                              ))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TabTitleUnCount(
                                    title: 'Dành cho bạn',
                                  ),
                                  DealsListButtonScreen(
                                    listProducts:
                                        controller.storeDetail.listProducts,
                                    isCategoryDetail: false,
                                  ),
                                ],
                              )),
                  ],
                ),
        ),
      ),
    );
  }
}
