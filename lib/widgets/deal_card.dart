import 'package:flutter/material.dart';
import 'package:vinhome_user/models/response/store_response.dart';
import '../models/response/mode3.dart';
import '../utils/screen_utils.dart';

class DealCard extends StatelessWidget {
  final StoreResponse? storeResponse;
  final ListStore? listStore;
  final bool isHorizontalScrolling;
  final VoidCallback? onTap;

  const DealCard(
      {Key? key,
      required this.storeResponse,
      required this.isHorizontalScrolling,
      this.onTap,
      this.listStore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = "";
    String name = "";
    String building = "";
    if (storeResponse != null) {
      image = storeResponse!.image;
      name = storeResponse!.name;
      building = storeResponse!.building;
    } else if (listStore != null) {
      image = listStore!.image;
      name = listStore!.name;
      building = listStore!.building;
    }

    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(
            left: isHorizontalScrolling
                ? getProportionateScreenWidth(16)
                : getProportionateScreenWidth(0),
            bottom: !isHorizontalScrolling
                ? getProportionateScreenHeight(32)
                : getProportionateScreenHeight(0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(8)),
                child: Image.network(
                  image,
                  width: getProportionateScreenWidth(115),
                  height: getProportionateScreenHeight(115),
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(14),
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${building}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
