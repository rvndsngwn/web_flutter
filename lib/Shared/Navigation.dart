import 'package:flutter/material.dart';

ScrollController mainPageController = ScrollController(
  keepScrollOffset: true,
);
final List<Widget> header = <Widget>[
  FlatButton(
    onPressed: () {
      mainPageController.animateTo(0,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOutCirc);
      // mainPageController.animateToPage(
      //   0,
      //   curve: Curves.easeIn,
      //   duration: Duration(milliseconds: 1000),
      // );
    },
    child: Text(
      'HOME',
    ),
  ),
  FlatButton(
    onPressed: () {
      mainPageController.animateTo(768,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOutCirc);
      // mainPageController.animateToPage(
      //   1,
      //   curve: Curves.easeIn,
      //   duration: Duration(milliseconds: 1000),
      // );
    },
    child: Text(
      'ABOUT',
    ),
  ),
  FlatButton(
    onPressed: () {
      mainPageController.animateTo(1270,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOutCirc);

      // mainPageController.animateToPage(
      //   2,
      //   curve: Curves.easeIn,
      //   duration: Duration(milliseconds: 1000),
      // );
    },
    child: Text(
      'DEMOS',
    ),
  ),
  FlatButton(
    onPressed: () {
      mainPageController.animateTo(1776,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOutCirc);
      // mainPageController.animateToPage(
      //   3,
      //   curve: Curves.easeIn,
      //   duration: Duration(milliseconds: 1000),
      // );
    },
    child: Text(
      'SKILLS',
    ),
  ),
];
