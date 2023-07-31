import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  final int mode;

  const Loading({Key? key, required this.mode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String file = "";
    switch (mode) {
      case 1:
        file = "assets/images/loading-mode1.json";
        break;
      case 2:
        file = "assets/images/loading-mode2.json";
        break;
      case 3:
        file = "assets/images/loading-mode3.json";
        break;
      default:
        file = "assets/images/loading-circle.json";
    }
    return Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
            ),
            Center(
              child: Lottie.asset(
                file,
                height: mode == -1 ? 300 : 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ));
  }
}
