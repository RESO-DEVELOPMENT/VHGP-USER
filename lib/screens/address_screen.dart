import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/address_controller.dart';
import 'package:vinhome_user/screens/routes/routes.dart';

import '../common/color.dart';
import '../widgets/information_card.dart';

class AddressScreen extends StatefulWidget {
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chọn địa chỉ nhận hàng',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: grey,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: const Color.fromRGBO(239, 239, 239, 1),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Địa chỉ'),
              ),
            ),
            GetBuilder<AddressController>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => controller
                              .addressList.length !=
                          index
                      ? InformationCard(address: controller.addressList[index])
                      : Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.createAddress);
                                },
                                child: const Text(
                                  'Thêm mới',
                                  style: TextStyle(color: primary),
                                )),
                          ),
                        ),
                  itemCount: controller.addressList.length + 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: Divider(
                      color: Colors.black12,
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
}
