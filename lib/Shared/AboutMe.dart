import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

extension WidgetPadding on Widget {
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);
}

final List<Widget> aboutme = <Widget>[
  ListTile(
    title: SelectableText(
      'About Me',
      style: TextStyle(fontSize: 45, color: Colors.black87),
      toolbarOptions: ToolbarOptions(
        copy: true,
        selectAll: true,
      ),
    ),
  ),
  ListTile(
    title: Text(
      'Experienced Mobile Developer, skilled in Cross-Platform( Flutter ), ',
      style: TextStyle(
        fontSize: 24,
        color: Colors.black54,
      ),
    ),
    subtitle: Wrap(
      alignment: WrapAlignment.spaceAround,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ActionChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 10, 203, 171),
              style: BorderStyle.solid,
              // width: 16,
            ),
          ),
          label: Text('Dart'),
          onPressed: () async {
            String url = 'https://dart.dev/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
        ActionChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 10, 203, 171),
              style: BorderStyle.solid,
              // width: 16,
            ),
          ),
          label: Text('Flutter'),
          onPressed: () async {
            String url = 'https://flutter.dev/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
        ActionChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 10, 203, 171),
              style: BorderStyle.solid,
              // width: 16,
            ),
          ),
          label: Text('C++'),
          onPressed: () async {
            String url = 'https://isocpp.org/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
        Chip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 10, 203, 171),
              style: BorderStyle.solid,
              // width: 16,
            ),
          ),
          label: Text('Python'),
        ),
      ],
    ).paddingAll(32),
  ),
];
