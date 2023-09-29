import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:walking_animation/constant.dart';
import 'package:walking_animation/provider/pageNotifier.dart';

class Rings extends StatefulWidget {
  const Rings({super.key});

  @override
  State<Rings> createState() => _RingsState();
}

class _RingsState extends State<Rings> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  final roateX = -128;
  final roateY = -8;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _sizeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageNotifier>(builder: (context, provider, _) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(80.w, 230.h),
            child: Transform.scale(
              scale: 0.82.r,
              child: Column(
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0011)
                      ..rotateX(0.01 * roateX)
                      ..rotateY(-0.01 * roateY),
                    alignment: FractionalOffset.center,
                    child: CustomPaint(
                      painter: OpenPainter(
                          animateValue: _sizeAnimation.value,
                          pageValue: provider.page),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0011)
                      ..rotateX(0.01 * roateX)
                      ..rotateY(-0.01 * roateY),
                    alignment: FractionalOffset.center,
                    child: CustomPaint(
                      painter: OpenPainter2(
                          animateValue: _sizeAnimation.value,
                          pageValue: provider.page),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0011)
                      ..rotateX(0.01 * roateX)
                      ..rotateY(-0.01 * roateY),
                    alignment: FractionalOffset.center,
                    child: CustomPaint(
                      painter: OpenPainter3(
                          animateValue: _sizeAnimation.value,
                          pageValue: provider.page),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class OpenPainter extends CustomPainter {
  OpenPainter({required this.animateValue, required this.pageValue});

  final animateValue;
  final double pageValue;
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = ringBGColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10 * (1 - min(1, pageValue * 2));
    //draw arc
    canvas.drawArc(
        const Offset(40, 350) & const Size(140, 140),
        3 * pi / 2, //radians
        2 * pi, //radians
        false,
        paint1);

    var paint2 = Paint()
      ..color = ring1Color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10 * (1 - min(1, pageValue * 2))
      ..strokeCap = StrokeCap.round;
    //draw arc
    canvas.drawArc(
        const Offset(40, 350) & const Size(140, 140),
        5.5, //radians
        3.2 * animateValue, //radians
        false,
        paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter2 extends CustomPainter {
  OpenPainter2({required this.animateValue, required this.pageValue});

  final animateValue;
  final double pageValue;
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = ringBGColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10 * (1 - min(1, pageValue * 2));
    //draw arc
    canvas.drawArc(
        const Offset(28, 338) & const Size(165, 165),
        pi, //radians
        2 * pi, //radians
        false,
        paint1);

    var paint2 = Paint()
      ..color = ring2Color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10 * (1 - min(1, pageValue * 2))
      ..strokeCap = StrokeCap.round;
    //draw arc
    canvas.drawArc(
        const Offset(28, 338) & const Size(165, 165),
        5.5, //radians
        3.8 * animateValue, //radians
        false,
        paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter3 extends CustomPainter {
  OpenPainter3({required this.animateValue, required this.pageValue});

  final animateValue;
  final double pageValue;
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = ringBGColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10 * (1 - min(1, pageValue * 2));
    //draw arc
    canvas.drawArc(
        const Offset(16, 326) & const Size(190, 190),
        3 * pi / 2, //radians
        2 * pi, //radians
        false,
        paint1);

    var paint2 = Paint()
      ..color = ring3Color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10 * (1 - min(1, pageValue * 2))
      ..strokeCap = StrokeCap.round;
    //draw arc
    canvas.drawArc(
        const Offset(16, 326) & const Size(190, 190),
        5.5, //radians
        4.2 * animateValue, //radians
        false,
        paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
