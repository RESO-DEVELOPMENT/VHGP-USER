import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/store_controller.dart';

import '../models/response/store_response.dart';
import '../screens/routes/routes.dart';

class StoreDetail extends StatelessWidget {
  final StoreResponse storeResponse;
  const StoreDetail({
    Key? key,
    required this.storeResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoreController controller = Get.find<StoreController>();
    return GestureDetector(
      onTap: () {
        controller.getStoreById(storeResponse.id, false);
        Get.toNamed(Routes.store);
      },
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: storeResponse.image,
                imageBuilder: (context, imageProvider) => Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeResponse.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                      ),
                      Text(storeResponse.building,
                          style: const TextStyle(fontSize: 13)),
                      Text(
                        storeResponse.storeCategory,
                        style: const TextStyle(
                            color: Color.fromRGBO(100, 100, 100, 1)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
