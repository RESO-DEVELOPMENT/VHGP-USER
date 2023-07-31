import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vinhome_user/widgets/add_product_button.dart';

import '../models/response/product_list.dart';
import '../utils/money_format.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key, this.onTap, required this.product})
      : super(key: key);
  final ListProduct product;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 245,
      width: 150,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: SizedBox(
                    height: 105,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
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
                Text(
                  product.storeName,
                  // ignore: prefer_const_constructors
                  style: const TextStyle(
                    color: Color.fromRGBO(
                      102,
                      102,
                      102,
                      1,
                    ),
                    fontSize: 12,
                  ),
                ),
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  viCurrency.format(product.pricePerPack),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(255, 170, 76, 1),
                      fontSize: 16),
                ),
                AddProduct(
                  product: product,
                  isCartScreen: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
