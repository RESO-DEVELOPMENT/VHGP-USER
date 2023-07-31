import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/address_controller.dart';
import 'package:vinhome_user/models/response/address.dart';

import '../common/color.dart';

class InformationCard extends StatefulWidget {
  const InformationCard({
    Key? key,
    required this.address,
  }) : super(key: key);

  final Address address;

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  @override
  Widget build(BuildContext context) {
    var isDefault = widget.address.isDefault;
    return GetBuilder<AddressController>(
      builder: (controller) => GestureDetector(
        onTap: () => setState(() {
          isDefault = 1;
          controller.setIsDefault(widget.address.accountBuildId.toString());
        }),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio(
                    value: 1,
                    groupValue: isDefault,
                    onChanged: (value) {
                      isDefault = 1;
                      controller.setIsDefault(
                          widget.address.accountBuildId.toString());
                      controller.getAddress();
                    }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: widget.address.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                              text: ' | ',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            TextSpan(
                              text: widget.address.soDienThoai,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        '${widget.address.buildingName}, ${widget.address.areaName} Vinhomes GP',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    widget.address.isDefault == 1
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: primary)),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Mặc định',
                                  style: TextStyle(color: primary),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ],
            ),
            // TextButton(
            //   onPressed: () => Get.toNamed(Routes.createAddress),
            //   style: TextButton.styleFrom(
            //     foregroundColor: primary,
            //   ),
            //   child: const Text(
            //     'Sửa',
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
