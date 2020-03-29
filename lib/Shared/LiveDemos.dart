import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_web/utils/Responsive.dart';

class Demos extends StatefulWidget {
  const Demos({Key key}) : super(key: key);

  @override
  _DemosState createState() => _DemosState();
}

class _DemosState extends State<Demos> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        desktop: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 768,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 480,
                  width: 380,
                  child: ListTile(
                    title: const Text(
                      'Live Demo',
                      style: const TextStyle(
                        fontSize: 45,
                      ),
                    ),
                    subtitle: const SelectableText(
                      'This a simple Bmi Calculator made using Flutter.\nProvider was used for state management and HiveDb for Data Persistence',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 750,
                  width: 480,
                  child: Card(
                    child: EasyWebView(
                      src: 'https://www.maheshwarravuri.com/bmicalculator/',
                      webAllowFullScreen: true,
                      height: 750,
                      width: 480,
                    ),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  ),
                ),
              ],
            ),
          ),
        ),
        mobile: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  // height: 480,
                  width: 480,
                  child: ListTile(
                    title: const Text(
                      'Live Demo',
                      style: const TextStyle(
                        fontSize: 45,
                      ),
                    ),
                    subtitle: const SelectableText(
                      'This a simple Bmi Calculator made using Flutter.\nProvider was used for state management and HiveDb for Data Persistence',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 750,
                  width: 480,
                  child: Card(
                    child: EasyWebView(
                      src: 'https://www.maheshwarravuri.com/bmicalculator/',
                      webAllowFullScreen: false,
                      height: 700,
                      width: 420,
                    ),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

final List<Widget> _demoUrls = [
  EasyWebView(
    src: 'https://www.maheshwarravuri.com/#/',
    webAllowFullScreen: false,
  ),
  EasyWebView(
    src: 'https://www.maheshwarravuri.com/bmicalculator/#/',
    webAllowFullScreen: true,
  ),
  EasyWebView(
    src: 'https://www.maheshwarravuri.com/FlyX-Web/#/',
    webAllowFullScreen: false,
  ),
];
