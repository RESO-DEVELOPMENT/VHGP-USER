import 'dart:ui';

class CategoryModel {
  final int id;
  final String name;
  final String image;
  final VoidCallback function;

  CategoryModel(this.id, this.name, this.image, this.function);
}
