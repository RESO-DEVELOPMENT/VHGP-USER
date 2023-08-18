import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/history_controller.dart';
import 'package:vinhome_user/screens/routes/routes.dart';
import 'package:vinhome_user/utils/date.dart';
import 'package:vinhome_user/utils/money_format.dart';
import 'package:vinhome_user/widgets/delivery_headline.dart';
import 'package:timelines/timelines.dart';
import 'package:vinhome_user/widgets/loading.dart';

import '../common/color.dart';

class HistoryDetailScreen extends StatefulWidget {
  const HistoryDetailScreen({Key? key}) : super(key: key);

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  final HistoryController historyController = Get.find<HistoryController>();
  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Chi tiết đơn hàng',
        ),
      ),
      body: GetBuilder<HistoryController>(
        builder: (controller) => controller.isLoading
            ? Loading(mode: -1)
            : Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DeliveryHeadline(
                            orderHistoryDetail: controller.orderHistoryDetail,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: orderInformation(
                                    context, textStyle, controller),
                              ),
                            ),
                          ),
                          deliveryTimeLine(textStyle, controller),
                          store(controller, textStyle),
                          payment(textStyle, context, controller),
                        ],
                      ),
                    ),
                  ),
                  total(textStyle, controller),
                ],
              ),
      ),
    );
  }

  Expanded total(TextStyle textStyle, HistoryController controller) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.topCenter,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng cộng:', style: Get.textTheme.titleLarge),
                Text(
                    viCurrency.format(controller.orderHistoryDetail.total +
                        controller.orderHistoryDetail.shipCost),
                    // viCurrency.format(controller.orderHistoryDetail.total +
                    // controller.orderHistoryDetail.shipCost),
                    style: Get.textTheme.titleLarge)
              ],
            )),
      ),
    );
  }

  Padding payment(
      TextStyle textStyle, BuildContext context, HistoryController controller) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('Chi tiết thanh toán',
                    style: Get.textTheme.titleMedium),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Hình thức thanh toán'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Image.asset(
                              'assets/images/money.png',
                              height: 24,
                            ),
                          ),
                          Flexible(
                              child: Text(
                            'Tiền mặt',
                            style: Get.textTheme.titleSmall,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InformationCard(
                title: 'Tổng tiền hàng',
                value: viCurrency.format(controller.orderHistoryDetail.total),
              ),
              InformationCard(
                title: 'Phí vận chuyển',
                value: viCurrency.format(
                    controller.orderHistoryDetail.shipCost -
                        (controller.orderHistoryDetail.serviceId == '1'
                            ? 10000
                            : 0)),
              ),
              InformationCard(
                title: 'Phí dịch vụ',
                value: viCurrency.format(
                    controller.orderHistoryDetail.serviceId == '1' ? 10000 : 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox orderInformation(
      BuildContext context, TextStyle textStyle, HistoryController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mã đơn hàng: ', style: Get.textTheme.titleSmall),
              Text(controller.orderHistoryDetail.id),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ngày đặt hàng: ', style: Get.textTheme.titleSmall),
                Text(
                  date.format(controller.orderHistoryDetail.time),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Địa chỉ: ', style: Get.textTheme.titleSmall),
              Text(
                  '${controller.orderHistoryDetail.buildingName} Vinhomes Green Park'),
            ],
          ),
        ],
      ),
    );
  }

  Padding deliveryTimeLine(TextStyle textStyle, HistoryController controller) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Tiến độ', style: Get.textTheme.titleMedium),
            ),
            FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                color: const Color.fromRGBO(28, 196, 97, 1),
                nodePosition: 0.1,
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemExtent: 60.0,
                itemCount: controller.deliveryTimeLine.length,
                indicatorBuilder: (_, index) {
                  bool here = index <=
                      controller.orderHistoryDetail.listStatusOrder.length - 1;
                  return Opacity(
                    opacity: here ? 1 : 0.6,
                    child: const OutlinedDotIndicator(
                      size: 15,
                      borderWidth: 2.5,
                      child: Icon(
                        Icons.circle,
                        color: Color.fromRGBO(28, 196, 97, 0.5),
                        size: 6.0,
                      ),
                    ),
                  );
                },
                connectorBuilder: (_, index, ___) => Opacity(
                  opacity: index <=
                          controller.orderHistoryDetail.listStatusOrder.length -
                              1
                      ? 1
                      : 0.6,
                  child: const SolidLineConnector(
                    color: Color(0xff66c97f),
                  ),
                ),
                contentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Opacity(
                    opacity: index <=
                            controller
                                    .orderHistoryDetail.listStatusOrder.length -
                                1
                        ? 1
                        : 0.6,
                    child: Row(
                      children: [
                        Image.asset(
                          controller.deliveryTimeLine[index].img,
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                  child: Text(
                                      controller.deliveryTimeLine[index].time)),
                              Text(controller.deliveryTimeLine[index].title,
                                  style: Get.textTheme.titleMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding store(HistoryController controller, TextStyle textStyle) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(controller.orderHistoryDetail.storeName,
                    style: Get.textTheme.titleMedium),
              ),
              const DividerApp(),
              orderProductList(controller)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox orderProductList(HistoryController historyController) {
    return SizedBox(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: historyController.orderHistoryDetail.listProInMenu.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        '${historyController.orderHistoryDetail.listProInMenu[index].quantity}x',
                        style: Get.textTheme.titleMedium),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                          historyController.orderHistoryDetail
                              .listProInMenu[index].productName,
                          style: Get.textTheme.titleSmall),
                    )),
                  ],
                ),
              ),
              Text(viCurrency.format(historyController
                  .orderHistoryDetail.listProInMenu[index].price)),
            ],
          ),
        ),
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 0.5,
          );
        },
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  final String title;
  final String value;

  const InformationCard({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title', style: Get.textTheme.titleSmall),
          Text(value, style: Get.textTheme.titleSmall),
        ],
      ),
    );
  }
}

class DividerApp extends StatelessWidget {
  const DividerApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(thickness: 0.5);
  }
}
