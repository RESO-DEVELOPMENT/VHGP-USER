import 'package:flutter/material.dart';
import '../common/color.dart';

class CustomNavBar extends StatefulWidget {
  final int curTabIndex;
  final Function(int) onTap;
  CustomNavBar(this.onTap, this.curTabIndex);
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (tabIndex) {
        widget.onTap(tabIndex);
      },
      selectedItemColor: kPrimaryGreen,
      unselectedItemColor: kGreyShade2,
      currentIndex: widget.curTabIndex,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: widget.curTabIndex == 0
              ? Image.asset(
                  'assets/images/home_nav.png',
                )
              : Image.asset(
                  'assets/images/home_nav_notfill.png',
                ),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: widget.curTabIndex == 1
              ? Image.asset(
                  'assets/images/cart_nav_fill.png',
                )
              : Image.asset(
                  'assets/images/cart_nav.png',
                ),
          label: 'Giao hàng',
        ),
        BottomNavigationBarItem(
          icon: widget.curTabIndex == 2
              ? Image.asset(
                  'assets/images/profile_nav_fill.png',
                )
              : Image.asset(
                  'assets/images/user_nav.png',
                ),
          label: 'Thông tin',
        ),
      ],
    );
  }
}
