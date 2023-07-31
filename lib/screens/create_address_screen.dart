import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/address_controller.dart';

import '../common/color.dart';

class CreateAddressScreen extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final AddressController addressController = Get.find<AddressController>();

  @override
  void initState() {
    addressController.isSubmit = false;
    addressController.getAreaList();
    addressController.getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin vận chuyển',
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: grey,
      ),
      body: GetBuilder<AddressController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Form(
              key: CreateAddressScreen._formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) => buildAreaPicker(),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Khu vực',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                " *",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey)),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(addressController.areaController.text),
                                const Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      if (addressController
                          .clusterOfBuildingController.text.isEmpty)
                        {
                          addressController.changeCluster(0),
                        },
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => buildClusterPicker(),
                      ),
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Cụm tòa nhà',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                " *",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey)),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(addressController
                                    .clusterOfBuildingController.text),
                                const Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        addressController.isSubmit &&
                                addressController.areaController.text.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: const Text(
                                  "Vui lòng chọn cụm tòa nhà",
                                  style: TextStyle(
                                      color: Color.fromRGBO(217, 48, 37, 1)),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      if (addressController.buildingController.text.isEmpty)
                        {
                          addressController.changeBuilding(0),
                        },
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => buildBuildingPicker(),
                      ),
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'Building(Tòa nhà)',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                " *",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey)),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(addressController.buildingController.text),
                                const Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        addressController.isSubmit &&
                                addressController
                                    .buildingController.text.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: const Text(
                                  "Vui lòng chọn tòa nhà",
                                  style: TextStyle(
                                      color: Color.fromRGBO(217, 48, 37, 1)),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'Tên người nhận',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        controller: addressController.userNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 8),
                        ),
                      ),
                      addressController.isSubmit &&
                              addressController.userNameController.text.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: const Text(
                                "Vui lòng nhập tên người nhận",
                                style: TextStyle(
                                    color: Color.fromRGBO(217, 48, 37, 1)),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'Số điện thoại nhận hàng',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        controller: addressController.phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 8),
                        ),
                      ),
                      addressController.isSubmit &&
                              addressController.phoneController.text.isEmpty
                          ? const Text(
                            "Vui lòng nhập số điện thoại",
                            style: TextStyle(
                                color: Color.fromRGBO(217, 48, 37, 1)),
                          )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  addressController.createAddress().then((value) {
                    if (value != -1) {
                      Get.back();
                    }
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                          colors: [primary, Color(0xfff7892b)])),
                  child: const Text(
                    'Xác nhận',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "SF Bold",
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildAreaPicker() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 180,
      child: CupertinoPicker(
        backgroundColor: Colors.white,
        itemExtent: 64,
        onSelectedItemChanged: (value) => addressController.changeArea(value),
        children: addressController.area
            .map(
              (e) => Center(
                child: Text(e.name),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildClusterPicker() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 180,
      child: CupertinoPicker(
        backgroundColor: Colors.white,
        itemExtent: 64,
        onSelectedItemChanged: (value) =>
            addressController.changeCluster(value),
        children: addressController.areaById.listCluster
            .map(
              (e) => Center(
                child: Text(e.name),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildBuildingPicker() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 180,
      child: CupertinoPicker(
        backgroundColor: Colors.white,
        itemExtent: 64,
        onSelectedItemChanged: (value) =>
            addressController.changeBuilding(value),
        children: addressController
            .areaById.listCluster[addressController.indexCluster].listBuilding
            .map(
              (e) => Center(
                child: Text(e.name),
              ),
            )
            .toList(),
      ),
    );
  }
}
