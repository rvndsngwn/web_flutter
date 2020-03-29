import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

final List<Widget> technicalSkills = <Widget>[
  ListTile(
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Flutter',
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    ),
    subtitle: LinearPercentIndicator(
      percent: .85,
      lineHeight: 15.0,
      animationDuration: 1500,
      animation: true,
      progressColor: Color.fromARGB(255, 10, 203, 171),
      addAutomaticKeepAlive: false,
      linearStrokeCap: LinearStrokeCap.roundAll,
    ),
  ),
  ListTile(
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Dart',
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    ),
    subtitle: LinearPercentIndicator(
      percent: .75,
      lineHeight: 15.0,
      animationDuration: 1500,
      animation: true,
      progressColor: Color.fromARGB(255, 10, 203, 171),
      addAutomaticKeepAlive: false,
      linearStrokeCap: LinearStrokeCap.roundAll,
    ),
  ),
  ListTile(
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'C++',
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    ),
    subtitle: LinearPercentIndicator(
      percent: .6,
      lineHeight: 15.0,
      animationDuration: 1500,
      animation: true,
      progressColor: Color.fromARGB(255, 10, 203, 171),
      addAutomaticKeepAlive: false,
      linearStrokeCap: LinearStrokeCap.roundAll,
    ),
  ),
  ListTile(
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Git',
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    ),
    subtitle: LinearPercentIndicator(
      percent: .8,
      lineHeight: 15.0,
      animationDuration: 1500,
      animation: true,
      progressColor: Color.fromARGB(255, 10, 203, 171),
      addAutomaticKeepAlive: false,
      linearStrokeCap: LinearStrokeCap.roundAll,
    ),
  ),
  ListTile(
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Python',
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    ),
    subtitle: LinearPercentIndicator(
      percent: .5,
      lineHeight: 15.0,
      animationDuration: 1500,
      animation: true,
      progressColor: Color.fromARGB(255, 10, 203, 171),
      addAutomaticKeepAlive: false,
      linearStrokeCap: LinearStrokeCap.roundAll,
    ),
  ),
];

final List<CircularPercentIndicator> professionalSkills =
    <CircularPercentIndicator>[
  CircularPercentIndicator(
    percent: .85,
    lineWidth: 15.0,
    radius: 120,
    animationDuration: 1500,
    animation: true,
    progressColor: Color.fromARGB(255, 10, 203, 171),
    addAutomaticKeepAlive: false,
    circularStrokeCap: CircularStrokeCap.round,
    footer: Text(
      'Communication',
      style: TextStyle(fontSize: 16, color: Colors.black87),
    ),
  ),
  CircularPercentIndicator(
    percent: .75,
    lineWidth: 15.0,
    radius: 120,
    animationDuration: 1500,
    animation: true,
    progressColor: Color.fromARGB(255, 10, 203, 171),
    addAutomaticKeepAlive: false,
    circularStrokeCap: CircularStrokeCap.round,
    footer: Text(
      'Team Work',
      style: TextStyle(fontSize: 16, color: Colors.black87),
    ),
  ),
  CircularPercentIndicator(
    percent: .65,
    lineWidth: 15.0,
    radius: 120,
    animationDuration: 1500,
    animation: true,
    progressColor: Color.fromARGB(255, 10, 203, 171),
    addAutomaticKeepAlive: false,
    circularStrokeCap: CircularStrokeCap.round,
    footer: Text(
      'Creativity',
      style: TextStyle(fontSize: 16, color: Colors.black87),
    ),
  ),
  CircularPercentIndicator(
    percent: .85,
    lineWidth: 15.0,
    radius: 120,
    animationDuration: 1500,
    animation: true,
    progressColor: Color.fromARGB(255, 10, 203, 171),
    addAutomaticKeepAlive: false,
    circularStrokeCap: CircularStrokeCap.round,
    footer: Text(
      'Project Management',
      style: TextStyle(fontSize: 16, color: Colors.black87),
    ),
  ),
];
