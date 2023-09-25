import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/product_controller.dart';
import 'package:vinhome_user/screens/routes/routes.dart';
import '../utils/screen_utils.dart';

class CategoryCard extends StatelessWidget {
  final dynamic category;
  final bool end;

  const CategoryCard(this.category, this.end);

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();
    return GestureDetector(
      onTap: () {
        productController.getProductByCategory(category.id);
        Get.toNamed(Routes.productCategory, arguments: category.name);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: getProportionateScreenWidth(24),
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              child: end
                  ? Image.asset(category.image)
                  : CachedNetworkImage(
                      imageUrl: category.image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text(
                category.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
