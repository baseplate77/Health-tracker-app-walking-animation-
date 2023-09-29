import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';
import 'package:provider/provider.dart';
import 'package:walking_animation/constant.dart';
import 'package:walking_animation/provider/pageNotifier.dart';
import 'package:walking_animation/screen/2.dart';
import 'package:walking_animation/screen/3.dart';

import 'provider/botton_nav_bar.dart';
import 'screen/1.dart';
import 'widget/botton_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottonNavBar>(create: (_) => BottonNavBar()),
        ChangeNotifierProvider<PageNotifier>(create: (_) => PageNotifier()),
      ],
      child: MaterialApp(
        builder: (ctx, child) {
          ScreenUtil.init(ctx, designSize: const Size(390, 844));
          return Theme(
            data: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: GoogleFonts.montserratTextTheme().copyWith()),
            child: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  ImageSequenceAnimatorState? get imageSequenceAnimator =>
      offlineImageSequenceAnimator;
  ImageSequenceAnimatorState? offlineImageSequenceAnimator;

  bool isOnline = false;
  bool wasPlaying = false;

  void onOfflineReadyToPlay(ImageSequenceAnimatorState imageSequenceAnimator) {
    offlineImageSequenceAnimator = imageSequenceAnimator;
    imageSequenceAnimator.setIsLooping(true);
  }

  void onOfflinePlaying(ImageSequenceAnimatorState imageSequenceAnimator) {
    scheduleMicrotask(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.addListener(() =>
          Provider.of<PageNotifier>(context, listen: false)
              .listener(_pageController.page!));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (int i = 0; i <= 38; i++) {
      String path = "assets/walking-animtaion/frame_00";
      if (i / 10 < 1) {
        path += "0$i.png";
      } else {
        path += "$i.png";
      }
      scheduleMicrotask(() async {
        await precacheImage(AssetImage(path), context);
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(
        Provider.of<PageNotifier>(context, listen: false)
            .listener(_pageController.page!));
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> screens = const [FristScreen(), SecondScreen(), SizedBox()];
  List<Widget> topLeftStats = const [
    UserStats(),
    TopLeftStat2(),
    SizedBox(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(
        pageController: _pageController,
      ),
      backgroundColor: bgColor,
      body: Consumer<PageNotifier>(builder: (context, provider, _) {
        return Stack(
          children: [
            SizedBox(
              height: 1.sh,
              width: 1.sw,
            ),
            PageView.builder(
              controller: _pageController,
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    screens[index],
                    Positioned(
                      left: 20.sp,
                      top: MediaQuery.of(context).viewPadding.top + 20.h,
                      child: CubeWidget(
                        index: index,
                        pageNotifier: provider.page,
                        child: topLeftStats[index],
                      ),
                    ),
                  ],
                );
              },
            ),
            Consumer<PageNotifier>(builder: (context, provider, _) {
              int index = provider.page.floor();
              final t = (provider.page.floor() - provider.page);
              // print(
              //     "t : $t index: ${provider.page.floor()} page : ${provider.page}");
              Offset s1 = Offset(40.w, 50.h);
              Offset s2 = Offset(0.w, 60.h);
              Offset s3 = Offset(0.w, 180.h);

              Size manScale1 = Size(400.w, 500.h);
              Size manScale2 = Size(650.w, 700.h);

              return Stack(
                children: [
                  SizedBox(
                    height: 1.sh,
                    width: 1.sw,
                  ),
                  Transform.translate(
                    offset: index == 2
                        ? Offset(lerpDouble(s3.dx, s2.dx, t.abs())!,
                            lerpDouble(s3.dy, s2.dy, t.abs())!)
                        : index == 1
                            ? Offset(lerpDouble(s2.dx, s3.dx, t.abs())!,
                                lerpDouble(s2.dy, s3.dy, t.abs())!)
                            : Offset(lerpDouble(s1.dx, s2.dx, t.abs())!,
                                lerpDouble(s1.dy, s2.dy, t.abs())!),
                    // offset: Offset(0.w, 60.h),
                    child: SizedBox(
                      // scale of the man
                      height: index == 2
                          ? manScale2.height
                          : index == 1
                              ? lerpDouble(
                                  manScale1.height, manScale2.height, t.abs())
                              : manScale1.height,
                      width: index == 2
                          ? manScale2.width
                          : index == 1
                              ? lerpDouble(
                                  manScale1.width, manScale2.width, t.abs())
                              : manScale1.width,

                      // child: Image.asset("assets/temp.png"),
                      child: ImageSequenceAnimator(
                        "assets/walking-animtaion",
                        "frame_",
                        1,
                        4,
                        "png",
                        38,
                        key: const Key("man-walking"),
                        fps: 30,
                        onReadyToPlay: onOfflineReadyToPlay,
                        onPlaying: onOfflinePlaying,
                      ),
                    ),
                  ),
                  // Last Scree
                  provider.page > 1
                      ? Transform.translate(
                          offset: index == 2
                              ? const Offset(0, 0)
                              : Offset(lerpDouble(1.sw, 0, t.abs())!, 0),
                          child: const ThreeScreen(),
                        )
                      : const SizedBox()
                  // provider.page > 1
                  //     ? Transform.translate(
                  //         offset: Offset(lerpDouble(a, b, t.abs()),
                  //             lerpDouble(a, b, t.abs())),
                  //         child: ThreeScreen())
                  //     : Container(
                  //         // Overlay deactivated
                  //         height: 0,
                  //         width: 0,
                  //       ),
                ],
              );
            }),
          ],
        );
      }),
      // body: ThreeScreen(),
    );
  }
}

class CubeWidget extends StatelessWidget {
  /// Index of the current item
  final int index;

  /// Page Notifier value, it comes from the [CubeWidgetBuilder]
  final double pageNotifier;

  /// Child you want to use inside the Cube
  final Widget child;

  const CubeWidget({
    Key? key,
    required this.index,
    required this.pageNotifier,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLeaving = (index - pageNotifier) <= 0;
    final t = (index - pageNotifier);
    final rotationY = lerpDouble(0, 90, t);
    final opacity = lerpDouble(1, 0, t.abs())?.clamp(0.0, 1.0).toDouble();
    final transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.003);
    transform.rotateY(-degToRad(rotationY!));
    return Transform(
      alignment: !isLeaving ? Alignment.centerRight : Alignment.centerLeft,
      transform: transform,
      child: Opacity(opacity: opacity!, child: child),
    );
  }
}

double degToRad(num deg) => deg * (pi / 180.0);
double radToDeg(num rad) => rad * (180.0 / pi);
