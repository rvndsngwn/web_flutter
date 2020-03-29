import 'package:flutter/widgets.dart';

class Responsive extends StatelessWidget {
  const Responsive({Key key, this.desktop, this.tablet, this.mobile})
      : super(key: key);

  @required
  final Widget desktop;

  final Widget mobile;
  final Widget tablet;

  // MediaQuery.of(context).size.shortestSide > 1000 ? desktop :
  //  MediaQuery.of(context).size.shortestSide > 1000 && MediaQuery.of(context).size.shortestSide < 1200 ? tablet ?? mobile :
  //   mobile;

  // LayoutBuilder(
  //   builder: (context, constraints) {
  //     if (constraints.maxWidth < 1000) {
  //       return mobile;
  //     } else if (constraints.maxWidth > 1000 && constraints.maxWidth < 1200) {
  //       return tablet ?? desktop;
  //     } else {
  //       return desktop;
  //     }
  //   },
  // );

  // static bool isMobile(BuildContext context) =>
  //     MediaQuery.of(context).size.width < 1000;

  // static bool isDesktop(BuildContext context) =>
  //     MediaQuery.of(context).size.width > 1000;

  // static bool isTablet(BuildContext context) =>
  //     MediaQuery.of(context).size.width > 1000 &&
  //     MediaQuery.of(context).size.width < 1200;

  @override
  Widget build(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide < 1000
          ? mobile
          : MediaQuery.of(context).size.shortestSide > 1000 &&
                  MediaQuery.of(context).size.shortestSide < 1200
              ? tablet ?? desktop
              : desktop;
}
