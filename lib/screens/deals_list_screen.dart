
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/widgets/tab_title_uncount.dart';

import '../controllers/store_controller.dart';
import '../widgets/store_detail.dart';

class DealsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (controller) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TabTitleUnCount(
              title: 'Món ngon gần bạn',
            ),
            SingleChildScrollView(
              child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => StoreDetail(
                        storeResponse: controller.storeResponses[index],
                      ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Colors.black12,
                        ),
                      ),
                  itemCount: controller.storeResponses.length),
            ),
          ],
        ),
        itemCount: controller.storeResponses.length,
      ),
    );
  }
}
