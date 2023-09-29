import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;
  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color selectedColor = Color(0xffE72758);
    const Color unSelectedColor = Color(0xff403E54);
    const iconMargin = EdgeInsets.zero;
    final double tabBarHeight = 80.h;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, -2),
            color: Colors.black12,
          ),
        ],
      ),
      child: TabBar(
        controller: tabController,
        // isScrollable: true,
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xffE72758),
            width: 4.0,
          ),
          insets: const EdgeInsets.fromLTRB(65.0, 0.0, 65.0, 10.0),
        ),

        labelColor: const Color(0xffE72758),

        unselectedLabelColor: const Color(0xff403E54),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.only(left: 16, right: 16),
        labelPadding: const EdgeInsets.all(0),
        indicatorColor: selectedColor,
        onTap: (value) {
          tabController.animateTo(value);
          int currentIndex = widget.pageController.page!.floor();
          print((value - currentIndex).abs() * 1000);
          widget.pageController.animateToPage(value,
              duration:
                  Duration(milliseconds: (value - currentIndex).abs() * 1000),
              curve: Curves.easeInOut);
          setState(() {});
        },
        tabs: [
          Tab(
            height: tabBarHeight,
            iconMargin: iconMargin,
            // text: "Home",
            // icon: Icon(Iconsax.),
            icon: SvgPicture.asset(
              'assets/icons/analytics.svg',
              width: 32.r,
              color: tabController.index == 0 ? selectedColor : unSelectedColor,
            ),
          ),
          Tab(
            height: tabBarHeight,
            iconMargin: iconMargin,
            // text: "Challenges",
            icon: SvgPicture.asset(
              "assets/icons/clock.svg",
              width: 32.r,
              color: tabController.index == 1 ? selectedColor : unSelectedColor,
            ),
          ),
          Tab(
            height: tabBarHeight,
            iconMargin: iconMargin,
            // text: "Relax",
            icon: SvgPicture.asset(
              "assets/icons/profile.svg",
              width: 30.r,
              color: tabController.index == 2 ? selectedColor : unSelectedColor,
            ),
          ),
        ],
      ),
    );

    // OLD APP BAR
    // return BottomNavigationBar(
    //   currentIndex: 0,
    //   items: [
    //     BottomNavigationBarItem(
    //         icon: Icon(
    //           Iconsax.home,
    //           size: 32.r,
    //         ),
    //         label: "Home"),
    //     BottomNavigationBarItem(
    //         icon: Icon(
    //           Iconsax.medal_star,
    //           size: 32.r,
    //         ),
    //         label: "Challenge"),
    //     BottomNavigationBarItem(
    //         icon: Icon(
    //           Iconsax.profile_circle,
    //           size: 32.r,
    //         ),
    //         label: "Profile"),
    //   ],
    // );
  }
}

enum MD2IndicatorSize {
  tiny,
  normal,
  full,
}

class MD2Indicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final MD2IndicatorSize indicatorSize;

  const MD2Indicator({
    required this.indicatorHeight,
    required this.indicatorColor,
    required this.indicatorSize,
  });

  @override
  _MD2Painter createBoxPainter([VoidCallback? onChanged]) {
    return _MD2Painter(this, onChanged);
  }
}

class _MD2Painter extends BoxPainter {
  final MD2Indicator decoration;

  _MD2Painter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    Rect rect;
    if (decoration.indicatorSize == MD2IndicatorSize.full) {
      rect = Offset(
            offset.dx,
            configuration.size!.height - decoration.indicatorHeight,
          ) &
          Size(configuration.size!.width, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == MD2IndicatorSize.tiny) {
      rect = Offset(
            offset.dx + configuration.size!.width / 2 - 8,
            configuration.size!.height - decoration.indicatorHeight,
          ) &
          Size(16, decoration.indicatorHeight);
    } else {
      rect = Offset(offset.dx + 6, 2) &
          Size(configuration.size!.width - 12, decoration.indicatorHeight);
    }

    final Paint paint = Paint()
      ..color = decoration.indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(rect,
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8)),
      paint,
    );
  }
}
