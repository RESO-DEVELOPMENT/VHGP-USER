import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/color.dart';
import '../controllers/address_controller.dart';
import '../screens/routes/routes.dart';

class DeliveryWidget extends StatelessWidget {
  const DeliveryWidget({
    Key? key,
    required this.addressController,
    required this.isHome,
  }) : super(key: key);

  final AddressController addressController;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Giao đến'),
        GestureDetector(
            child: Container(
              height: isHome ? 45 : 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: isHome
                    ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15)
                    : const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [primary, Color(0xfff7892b)],
                        ).createShader(bounds);
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                    ),
                    GetBuilder<AddressController>(
                      builder: (controller) => Text(
                        controller.building,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () => {
                  addressController.getAreaList(),
                  addressController.getAddress(),
                  Get.toNamed(Routes.address),
                })
      ],
    );
  }
}
