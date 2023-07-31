import 'package:flutter/material.dart';

class EmptyFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/empty-food.png',
            height: 50,
            fit: BoxFit.cover,
          ),
          const Text(
            'Không có sản phẩm nào!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            child: const Text(
              'Hiện không có sản phẩm nào, Bạn vui lòng quay lại vào lúc khác.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
