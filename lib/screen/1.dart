import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../provider/pageNotifier.dart';
import '../widget/rings.dart';

class FristScreen extends StatefulWidget {
  const FristScreen({super.key});

  @override
  State<FristScreen> createState() => _FristScreenState();
}

class _FristScreenState extends State<FristScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 1.sh,
          width: 1.sw,
        ),
        const Rings(),
        Positioned(
          bottom: 20.r,
          left: 20.r,
          right: 20.r,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/pizza.jpg",
                  width: 75.r,
                  height: 75.r,
                ),
                SizedBox(
                  width: 20.r,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "A Simple way to \nstay healthy",
                      style: TextStyle(color: textColor, fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 10.r,
                    ),
                    const Text(
                      "DR Melissa",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  "assets/icons/light.svg",
                  width: 16.sp,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class UserStats extends StatefulWidget {
  const UserStats({
    super.key,
  });

  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageNotifier>(builder: (context, provider, _) {
      // print("form consumer : ${provider.page}");
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopLeftStat1(),
          SizedBox(
            height: 20.sp,
          ),
          const InfoWidget(
            filePath: "assets/icons/fire.svg",
            topText: "1,880",
            bottomText: "Calories",
          ),
          SizedBox(
            height: 20.sp,
          ),
          const InfoWidget(
            filePath: "assets/icons/steps.svg",
            topText: "5,248",
            bottomText: "steps",
          ),
          SizedBox(
            height: 20.sp,
          ),
          const InfoWidget(
            filePath: "assets/icons/moon.svg",
            topText: "5.6",
            bottomText: "hours",
          ),
        ],
      );
    });
  }
}

class TopLeftStat1 extends StatelessWidget {
  const TopLeftStat1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DAILY GOAL",
          style: TextStyle(
              fontSize: 24.sp, color: textColor, fontWeight: FontWeight.bold),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '87',
                style: TextStyle(fontSize: 84.sp, color: textColor),
              ),
              TextSpan(
                text: '%',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.filePath,
    required this.topText,
    required this.bottomText,
  });

  final String filePath;
  final String topText;
  final String bottomText;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          filePath,
          width: 26.r,
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topText,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              bottomText,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ],
    );
  }
}
