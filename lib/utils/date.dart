import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vinhome_user/common/color.dart';
import 'package:flutter/material.dart';

final dateFormat = DateFormat('Hm');
final date = DateFormat('dd/MM/yyyy');

class Status {
  static const String CREATEORDER = "1";
  static const String SHIPPERACCEPT = "2";
  static const String SHIPPING = "3";
  static const String DONE = "4";
  static const String CANCEL = "5";

  static String getStatusName(status) {
    if (status == 0) {
      return "Tạo dơn thành công";
    } else if (status == 1) {
      return "Cửa hàng nhận đơn";
    } else if (status == 2) {
      return "Đang tìm tài xế";
    } else if (status == 3) {
      return "Tài xế nhận đơn";
    } else if (status == 4) {
      return "Đang giao";
    } else if (status == 5) {
      return "Hoàn thành";
    } else if (status == 6) {
      return "Giao hàng thất bại";
    } else if (status == 7) {
      return "Đang đến điểm giao hàng";
    } else if (status == 8) {
      return "Đang ở điểm giao hàng";
    } else if (status == 9) {
      return "Đang giao đến khách";
    } else if (status == 10) {
      return "Tự động hủy";
    } else if (status == 11) {
      return "Huỷ bởi cửa hàng";
    } else if (status == 12) {
      return "Tài xế hủy";
    } else if (status == 13) {
      return "Khách hàng hủy";
    } else {
      return "Đã hủy";
    }
  }

  static Color? getStatusColorText(status) {
    if (status == 0 || status == 1 || status == 2 || status == 3) {
      return MaterialColors.primary;
    } else if (status == 7 || status == 8 || status == 9 || status == 4) {
      return MaterialColors.secondary;
    } else if (status == 5) {
      return MaterialColors.success;
    } else {
      return Colors.red[600];
    }
  }

  static List<Color>? getStatusColor(status) {
    if (status == 0 || status == 1 || status == 2 || status == 3) {
      return [MaterialColors.primary, Color(0xfff7892b)];
    } else if (status == 7 || status == 8 || status == 9 || status == 4) {
      return [Color.fromARGB(255, 32, 129, 209), MaterialColors.secondary];
    } else if (status == 5) {
      return [Colors.green, MaterialColors.success];
    } else {
      return [Colors.redAccent, Colors.red];
    }
  }
}

class MaterialColors {
  static const Color primary = Color.fromRGBO(255, 170, 76, 1);
  static const Color black = Color.fromRGBO(24, 23, 37, 1.0);
  static const Color secondary = Color.fromRGBO(14, 105, 180, 1.0);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color grey = Color.fromRGBO(245, 245, 245, 1);
  static const Color success = Color.fromARGB(176, 0, 163, 54);
}
