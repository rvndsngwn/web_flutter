import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:portfolio_web/Shared/SubPages.dart';
import 'package:portfolio_web/utils/Responsive.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Cache');
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Scrollbar(
          child: CustomScrollView(
            slivers: <Widget>[
              // SliverAppBar(
              //   centerTitle: true,
              //   pinned: true,
              //   elevation: 4,
              //   primary: true,
              //   automaticallyImplyLeading: true,
              //   backgroundColor: Color.fromARGB(
              //     225,
              //     250,
              //     250,
              //     250,
              //   ),
              //   title: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: <Widget>[...header],
              //     ),
              //   ),
              // ),
              Responsive(
                desktop: SliverFixedExtentList(
                  itemExtent: 800,
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => subPages.elementAt(
                      i,
                    ),
                    childCount: subPages.length,
                  ),
                ),
                mobile: SliverFixedExtentList(
                  itemExtent: 1000,
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => subPages.elementAt(
                      i,
                    ),
                    childCount: subPages.length,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
