import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vinhome_user/common/color.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/history_controller.dart';
import 'package:vinhome_user/utils/money_format.dart';

import 'routes/routes.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryController historyController = Get.find<HistoryController>();

  @override
  initState() {
    super.initState();
    historyController.getitemFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Lịch sử giao hàng',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<HistoryController>(
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextField(
                      controller: historyController.orderIdTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(13),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment(1, 1),
                          colors: <Color>[
                            Color.fromRGBO(247, 143, 43, 1),
                            Color.fromRGBO(255, 175, 76, 1),
                            Color.fromRGBO(248, 219, 176, 1)
                          ], //
                        ),
                      ),
                      child: IconButton(
                        iconSize: 25,
                        color: Colors.white,
                        icon: const Icon(Icons.search),
                        onPressed: () async {
                          await historyController
                              .getOrderHistoryDetail(
                                  historyController.orderIdTextController.text)
                              .then((value) => {
                                    if (value == 200)
                                      {
                                        Get.toNamed(Routes.historyDetail),
                                      }
                                    else
                                      {
                                        showAlertDialog(context),
                                      }
                                  });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Bạn có ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                        text:
                            historyController.orderHistories.length.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: primary),
                      ),
                      const TextSpan(
                          text: ' đơn hàng!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: SingleChildScrollView(
                child: ListView.builder(
                  reverse: true,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: historyController.orderHistories.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () => {
                            historyController.getOrderHistoryDetail(
                                historyController.orderHistories[index].id),
                            Get.toNamed(Routes.historyDetail)
                          },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '#${historyController.orderHistories[index].id}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  viCurrency.format(double.parse(
                                      historyController
                                          .orderHistories[index].price)),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> showAlertDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/search-not-found.gif",
                    width: 300, fit: BoxFit.cover),
                const Text(
                  "Không tìm thấy đơn hàng",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade200,
                              offset: const Offset(2, 4),
                              blurRadius: 5,
                              spreadRadius: 2)
                        ],
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.redAccent,
                              Colors.red,
                            ])),
                    child: const Text(
                      'Quay lại',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "SF Bold",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
