import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../constant.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 1.sh,
          width: 1.sw,
        ),
        Transform.rotate(
          angle: 0.48,
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.005)
              ..rotateX(0.01 * -95)
              ..rotateY(-0.01 * -28),
            child: SizedBox(
              width: 100,
              height: 400,
              child: CustomPaint(
                painter: OpenPainter(),
              ),
            ),
          ),
        ),
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
                  "assets/location.png",
                  width: 75.r,
                  height: 75.r,
                ),
                SizedBox(
                  width: 20.r,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "10.42",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Morning Walk",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Text(
                      "2km in 30 mins",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  "assets/icons/walking.svg",
                  width: 16.sp,
                )
              ],
            ),
          ),
        )
        // Transform.translate(
        //   offset: Offset(0.w, 60.h),
        //   child: SizedBox(
        //     height: 500.h,
        //     width: 400.w,
        //     child: Image.asset("assets/temp.png"),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(25),
        //   child: ImageSequenceAnimator(
        //     "assets/walking-animtaion",
        //     "frame_",
        //     0,
        //     5,
        //     "png",
        //     41,
        //     key: const Key("man-walking"),
        //     fps: 38,
        //     onReadyToPlay: onOfflineReadyToPlay,
        //     onPlaying: onOfflinePlaying,
        //   ),
        // ),
      ],
    );
  }
}

class TopLeftStat2 extends StatelessWidget {
  const TopLeftStat2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "JOURNAL",
          style: TextStyle(
              fontSize: 24.sp, color: textColor, fontWeight: FontWeight.bold),
        ),
        Text(
          "13",
          style: TextStyle(fontSize: 84.sp, color: textColor),
        ),
        Text(
          "Sept 2021",
          style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade500),
        )
      ],
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = secondaryBgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 80;
    //draw arc
    canvas.drawArc(
        const Offset(-320, 0) & const Size(400, 400),
        3 * pi / 2, //radians
        3, //radians
        false,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
