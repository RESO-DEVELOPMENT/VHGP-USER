import 'package:flutter/material.dart';
import 'package:vinhome_user/common/color.dart';

import '../models/response/order_history_detail.dart';
import '../utils/date.dart';

class DeliveryHeadline extends StatelessWidget {
  final OrderHistoryDetail orderHistoryDetail;

  const DeliveryHeadline({Key? key, required this.orderHistoryDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 170, 76, 0.1),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            SizedBox(
              height: 35,
              child: Image.asset(
                'assets/images/delivery_icon.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Đang giao hàng',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 170, 76, 1),
                        fontWeight: FontWeight.w700),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Đơn hàng sẽ được giao vào ',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 170, 76, 1),
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                          text:
                              '${orderHistoryDetail.modeId == '1' ? dateFormat.format(orderHistoryDetail.time.add(const Duration(minutes: 20))) : "\n" + date.format(orderHistoryDetail.time)} - ${dateFormat.format(orderHistoryDetail.time.add(const Duration(minutes: 30)))}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
