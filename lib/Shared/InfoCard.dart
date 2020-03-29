import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'dart:html' as html;

final List<Widget> infoCard = <Widget>[
  Align(
    alignment: Alignment.center,
    child: Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        // BorderRadius.only(
        //   topLeft: Radius.circular(24),
        //   topRight: Radius.circular(24),
        //   bottomRight: Radius.circular(24),
        // ),
      ),
      color: Color.fromARGB(255, 10, 203, 171),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: Text(
          'Hello I\'m',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    ),
  ),
  SizedBox(
    height: 30,
  ),
  ListTile(
    title: SelectableText(
      'Maheshwar Ravuri',
      style: TextStyle(fontSize: 45),
      toolbarOptions: ToolbarOptions(
        copy: true,
        selectAll: true,
      ),
    ),
    subtitle: Text(
      'Mobile Developer',
      style: TextStyle(fontSize: 35),
    ),
  ),
  Column(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.my_location),
        title: SelectableText(
          'Fresno, CA, United States',
          toolbarOptions: ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.email),
        title: SelectableText(
          'maheshwar.ravuri@gmail.com',
          toolbarOptions: ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.phone),
        title: SelectableText(
          '+1 224 532 6151',
          toolbarOptions: ToolbarOptions(
            copy: true,
            selectAll: true,
          ),
        ),
      ),
      Container(
        child: ButtonBar(
          //mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.start,

          children: <Widget>[
            Card(
              shape: CircleBorder(
                side: BorderSide(
                  color: Color.fromARGB(255, 10, 203, 171),
                  style: BorderStyle.solid,
                  // width: 16,
                ),
              ),
              child: IconButton(
                  icon: Icon(FontAwesome5Brands.github),
                  tooltip: 'https://github.com/Mravuri96',
                  onPressed: () async {
                    String url = 'https://github.com/Mravuri96';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                  // html.window.open(
                  //     'https://github.com/Mravuri96',
                  //     'github'), // No functionality yet
                  ),
            ),
            Card(
              shape: CircleBorder(
                side: BorderSide(
                  color: Color.fromARGB(255, 10, 203, 171),
                  style: BorderStyle.solid,
                  // width: 16,
                ),
              ),
              child: IconButton(
                  icon: Icon(
                    FontAwesome5Brands.twitter,
                    color: Color.fromARGB(255, 29, 161, 242),
                  ),
                  tooltip: 'https://twitter.com/MaheshwarRavuri',
                  onPressed: () async {
                    String url = 'https://twitter.com/MaheshwarRavuri';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                  // html.window.open(
                  //     'https://twitter.com/MaheshwarRavuri',
                  //     'Twitter'), // No functionality yet
                  ),
            ),
          ],
        ),
      ),
    ],
  ),
];
