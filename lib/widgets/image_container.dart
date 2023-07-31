import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/user_controller.dart';
import '../common/color.dart';
import '../models/response/user.dart';
import '../utils/screen_utils.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return GestureDetector(
      onTap: () => pickupImage(context, userController),
      child: GetBuilder<UserController>(
        builder: (controller) => Container(
          height: getProportionateScreenWidth(112),
          width: getProportionateScreenWidth(112),
          child: Stack(
            children: [
              userController.user.imageUrl == null ||
                      userController.user.imageUrl == ''
                  ? Container(
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: kGreyShade5,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: userController.user.imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    padding: EdgeInsets.all(
                      getProportionateScreenWidth(8),
                    ),
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: kPrimaryGreen,
                    ),
                    child: Image.asset('assets/images/camera.png')),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future pickupImage(BuildContext context, UserController controller) {
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return _pickupImage(context, controller);
    },
  );
}

SizedBox _pickupImage(BuildContext context, UserController controller) {
  return SizedBox(
    child: Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: ListTile.divideTiles(context: context, tiles: [
                    ListTile(
                      onTap: () {
                        Get.back();
                        controller.pickImage(true);
                      },
                      title: Center(
                        child: Text(
                          'Chụp ảnh',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        controller.pickImage(false);
                      },
                      title: Center(
                        child: Text(
                          'Ảnh',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ]).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: ListTile(
                  onTap: () => Get.back(),
                  title: Center(
                    child: Text(
                      'Hủy',
                      style: const TextStyle(
                          fontSize: 18, color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
