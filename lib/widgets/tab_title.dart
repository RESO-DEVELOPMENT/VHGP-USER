import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../utils/screen_utils.dart';

class TabTitle extends StatefulWidget {
  final String title;
  final String? actionText;
  final Function? seeAll;
  final double? padding;
  final double endTime;

  const TabTitle(
      {required this.title,
      this.seeAll,
      this.actionText = 'Xem thêm',
      this.padding = 16,
      required this.endTime});

  @override
  State<TabTitle> createState() => _TabTitleState();
}

class _TabTitleState extends State<TabTitle> {
  var countDownHour = 0.0;
  var countDownMinus = 0;
  var countDownSecond = 0;
  num countDownTime = 0;
  var res;
  late DateTime nowDate = DateTime.now();
  Duration countTime = Duration();
  @override
  // ignore: must_call_super
  initState() {
    List<String> hourString = widget.endTime.toString().split(".");
    DateTime endDate = DateTime(nowDate.year, nowDate.month, nowDate.day,
        int.parse(hourString[0]), 0, 0, 0);
    countTime =
        endDate.difference(nowDate.subtract(const Duration(minutes: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
          widget.padding!,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          widget.endTime != -1
              ? SlideCountdownSeparated(
                  shouldShowHours: (p0) => true,
                  duration: countTime,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                )
              : Container(),
          // if (seeAll != null)
          //   TextButton(
          //     onPressed: () => seeAll,
          //     child: Text(
          //       actionText!,
          //       style: TextStyle(fontSize: 14, color: primary),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
