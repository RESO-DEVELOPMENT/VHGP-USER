import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../utils/screen_utils.dart';
import '../models/category.dart';

class TypeyCard extends StatelessWidget {
  final Category category;

  const TypeyCard(
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      beginDuration: const Duration(milliseconds: 300),
      endDuration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Container(
              color: Colors.grey[300],
              width: getProportionateScreenWidth(80),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  category.catIcon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
              width: 70,
              child: Text(
                category.catName,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
