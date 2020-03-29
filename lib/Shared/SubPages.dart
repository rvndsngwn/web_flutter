import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_web/Shared/AboutMe.dart';
import 'package:portfolio_web/Shared/InfoCard.dart';
import 'package:portfolio_web/Shared/Skills.dart';
import 'package:portfolio_web/utils/Responsive.dart';

final List<Widget> subPages = const <Widget>[
  ProfilePage(),
  AboutPage(),
  LiveDemoPage(),
  SkillsPage(),
];

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children2 = <Widget>[
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 480,
        ),
        child: ListView.builder(
          itemBuilder: (ctx, i) => AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
              position: i,
              child: FadeInAnimation(
                child: infoCard.elementAt(i),
              ),
            ),
          ),
          itemCount: infoCard.length,
          shrinkWrap: true,
        ),
      ),
      Card(
        shape: const CircleBorder(),
        elevation: 8,
        margin: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Container(
          height: 480,
          width: 480,
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.luminosity,
            color: Colors.transparent,
            //            borderRadius: BorderRadius.circular(40),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/Profile.jpg',
              ),
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ];
    return Responsive(
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[..._children2],
      ),
      mobile: Column(
        children: <Widget>[..._children2.reversed],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children2 = <Widget>[
      Container(
        height: 480,
        width: 480,
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.luminosity,
          color: Colors.transparent,
          //            borderRadius: BorderRadius.circular(40),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/svg.png',
            ),
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
        ),
      ),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 480,
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, i) => AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
              position: i,
              child: FadeInAnimation(
                child: aboutme.elementAt(i),
              ),
            ),
          ),
          itemCount: aboutme.length,
          shrinkWrap: true,
        ),
      ),
    ];
    return Responsive(
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[..._children2],
      ),
      mobile: Column(
        children: <Widget>[..._children2],
      ),
    );
  }
}

class LiveDemoPage extends StatelessWidget {
  const LiveDemoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children2 = <Widget>[
      SizedBox(
        // height: 480,
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        ),
      ),
    ];
    return Responsive(
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _children2,
      ),
      mobile: Column(
        children: <Widget>[..._children2],
      ),
    );
  }
}

class SkillsPage extends StatelessWidget {
  const SkillsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children2 = <Widget>[
      Container(
        width: 480,
        height: 480,
        child: ListTile(
          title: const Text(
            'Techinical Skills',
            style: TextStyle(fontSize: 24),
          ),
          subtitle: ListView.builder(
            itemCount: technicalSkills.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (c, i) => AnimationLimiter(
              child: AnimationConfiguration.staggeredGrid(
                child: FadeInAnimation(
                  //  delay: Duration(milliseconds: 500),
                  // duration: Duration(seconds: 1),
                  child: technicalSkills[i],
                ),
                position: i,
                columnCount: 2,
              ),
            ),
          ),
        ),
      ),
      Container(
        width: 480,
        height: 480,
        child: ListTile(
          title: const Text(
            'Professional Skills',
            style: TextStyle(fontSize: 24),
          ),
          subtitle: GridView.builder(
            itemCount: professionalSkills.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (c, i) => AnimationLimiter(
              child: AnimationConfiguration.staggeredList(
                child: FadeInAnimation(
                  //  delay: Duration(milliseconds: 500),
                  // duration: Duration(seconds: 1),
                  child: professionalSkills[i],
                ),
                position: i,
              ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          ),
        ),
      ),
    ];
    return Responsive(
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[..._children2],
      ),
      mobile: Column(
        children: <Widget>[..._children2],
      ),
    );
  }
}
