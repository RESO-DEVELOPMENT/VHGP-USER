import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/home_controller.dart';
import 'package:vinhome_user/widgets/loading.dart';
import 'package:vinhome_user/widgets/store_detail.dart';

import '../common/color.dart';
import '../controllers/address_controller.dart';
import '../widgets/delivery.widget.dart';
import '../widgets/fillter_category.dart';
import '../widgets/scheduler_week.dart';

class FilterWeekMode3 extends StatelessWidget {
  const FilterWeekMode3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.find<AddressController>();

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
            ? Loading(mode: -1)
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SchedulerWeek(
                              menuMode3: controller.menuMode3.menuMode3S[index],
                              index: index,
                            ),
                          ),
                          itemCount: controller.menuMode3.menuMode3S.length,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    color: Color.fromRGBO(247, 246, 246, 1),
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.015),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: GetBuilder<HomeController>(
                                builder: (controller) => GestureDetector(
                                  onTap: () {
                                    controller
                                        .changeChoideIndexCategoryByView(-1);
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.grey.shade200,
                                              offset: const Offset(2, 4),
                                              blurRadius: 5,
                                              spreadRadius: 2)
                                        ],
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: -1 ==
                                                    controller
                                                        .choideIndexCategoryByView
                                                ? [primary, primary2]
                                                : [
                                                    Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    Color.fromARGB(
                                                        255, 255, 255, 255)
                                                  ])),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Text(
                                        'Tất cả',
                                        style: TextStyle(
                                            color: -1 ==
                                                    controller
                                                        .choideIndexCategoryByView
                                                ? Colors.white
                                                : primary),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FilterByCategory(
                                    categoryInMenuView: controller
                                        .menuMode3.categoryInMenuViews[index],
                                    index: index),
                              ),
                              itemCount: controller
                                  .menuMode3.categoryInMenuViews.length,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: controller.menuMode3.stores.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: Colors.black12,
                                ),
                              ),
                          itemBuilder: (context, index) => StoreDetail(
                              storeResponse:
                                  controller.menuMode3.stores[index])),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
