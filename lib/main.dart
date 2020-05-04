import 'package:flutter/material.dart'
    show
        Align,
        AssetImage,
        Axis,
        BorderRadius,
        BouncingScrollPhysics,
        BoxConstraints,
        BuildContext,
        ButtonBar,
        Card,
        Center,
        CircleAvatar,
        CircleBorder,
        Column,
        ConstrainedBox,
        EdgeInsets,
        FloatingActionButton,
        GridView,
        Icon,
        IconButton,
        IconTheme,
        Icons,
        Image,
        Key,
        ListTile,
        ListView,
        MaterialApp,
        NeverScrollableScrollPhysics,
        Padding,
        Radius,
        RaisedButton,
        RoundedRectangleBorder,
        Scaffold,
        Scrollbar,
        SelectableText,
        SizedBox,
        StadiumBorder,
        StatelessWidget,
        Text,
        Theme,
        ThemeData,
        ThemeMode,
        ToolbarOptions,
        Tooltip,
        ValueListenableBuilder,
        VisualDensity,
        Widget,
        WidgetsFlutterBinding,
        Wrap,
        WrapAlignment,
        WrapCrossAlignment,
        runApp;
import 'package:flutter_icons/flutter_icons.dart'
    show FontAwesome, FontAwesome5Brands;
import 'package:hive/hive.dart' show Hive;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart'
    show CircularPercentIndicator, CircularStrokeCap;
import 'package:percent_indicator/linear_percent_indicator.dart'
    show LinearPercentIndicator, LinearStrokeCap;
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;

Future<void> main() async => Hive.initFlutter()
    .whenComplete(
      () async => Hive.openBox(
        'darkMode',
      ),
    )
    .whenComplete(WidgetsFlutterBinding.ensureInitialized)
    .whenComplete(
      () => runApp(
        const Home(),
      ),
    );

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('darkMode').listenable(),
      builder: (_, box, __) {
        final _isDarkMode = box.get('darkMode', defaultValue: false);
        return MaterialApp(
          themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark()
              .copyWith(visualDensity: VisualDensity.adaptivePlatformDensity),
          theme: ThemeData.light()
              .copyWith(visualDensity: VisualDensity.adaptivePlatformDensity),
          home: Scaffold(
            body: const Center(
              child: HomePage(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => box.put('darkMode', !_isDarkMode),
              child: Icon(_isDarkMode ? FontAwesome.sun_o : FontAwesome.moon_o),
            ),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        addRepaintBoundaries: true,
        addAutomaticKeepAlives: true,
        primary: true,
        children: <Widget>[
          const SizedBox(
            height: 64,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 32,
            spacing: 64,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              CircleAvatar(
                minRadius: 50,
                maxRadius: 240,
                backgroundImage: AssetImage(
                  'assets/images/Profile.jpeg',
                ),
              ),
              SizedBox(
                width: 500,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  child: Info(),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 64,
          ),
          Wrap(
            runAlignment: WrapAlignment.center,
            runSpacing: 32,
            spacing: 64,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset(
                'assets/images/svg.png',
                width: 500,
                isAntiAlias: true,
              ),
              const SizedBox(
                width: 500,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  child: AboutMe(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 64,
          ),
          const ProjectShowCase(),
          const SizedBox(
            height: 64,
          ),
          Wrap(
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 32,
            spacing: 64,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              TechnicalSkills(),
              ProfessionalSkills(),
            ]
                .map(
                  (e) => SizedBox(
                    width: 500,
                    child: Card(
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: e,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(24),
      children: [
        Align(
          child: FloatingActionButton.extended(
            shape: const StadiumBorder(),
            highlightElevation: 2,
            elevation: 2,
            onPressed: null,
            label: const Text(
              "Hello I'm",
              textScaleFactor: 1.5,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const ListTile(
          leading: Icon(Icons.account_circle),
          title: SelectableText(
            'Maheshwar Ravuri',
            textScaleFactor: 2,
            toolbarOptions: ToolbarOptions(
              copy: true,
              selectAll: true,
            ),
          ),
          subtitle: Text(
            'Mobile Developer',
          ),
        ),
        ...const [
          [
            Icon(Icons.location_on),
            'Fresno, CA, United States',
          ],
          [
            Icon(Icons.email),
            'maheshwar.ravuri@gmail.com',
          ],
          [
            Icon(Icons.phone),
            '+1 224 532 6151',
          ]
        ]
            .map(
              (e) => ListTile(
                leading: e.first,
                title: SelectableText(
                  e.last,
                  toolbarOptions: const ToolbarOptions(
                    copy: true,
                    selectAll: true,
                  ),
                ),
              ),
            )
            .toList(),
        ButtonBar(
          children: [
            [FontAwesome5Brands.github, 'https://github.com/Mravuri96'],
            [FontAwesome5Brands.twitter, 'https://twitter.com/MaheshwarRavuri']
          ]
              .map(
                (e) => Tooltip(
                  message: 'Visit ${e.last}',
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    shape: const CircleBorder(),
                    onPressed: () async {
                      if (await canLaunch(e.last)) {
                        await launch(e.last);
                      }
                    },
                    child: Icon(
                      e.first,
                      size: IconTheme.of(context).size - 4,
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

class TechnicalSkills extends StatelessWidget {
  const TechnicalSkills({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(
        24,
      ),
      children: [
        const Align(
          child: Text(
            'Technical Skills',
            textScaleFactor: 2,
          ),
        ),
        const SizedBox(
          height: 64,
        ),
        ...[
          ['Flutter', .85],
          ['Dart', .75],
          ['C#', .5],
          ['C++', .5],
          ['git', .85],
          ['Python', .5]
        ]
            .map(
              (e) => ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    e.first,
                  ),
                ),
                subtitle: LinearPercentIndicator(
                  percent: e.last,
                  lineHeight: 15,
                  animationDuration: 1500,
                  animation: true,
                  progressColor: Theme.of(context).accentColor,
                  addAutomaticKeepAlive: true,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}

class ProfessionalSkills extends StatelessWidget {
  const ProfessionalSkills({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(
        24,
      ),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const Align(
          child: Text(
            'Professional Skills',
            textScaleFactor: 2,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: [
            ['Communication', .85],
            ['Team Work', .75],
            ['Creativity', .65],
            ['Project Management', .85],
          ]
              .map(
                (e) => CircularPercentIndicator(
                  percent: e.last,
                  lineWidth: 15,
                  radius: 120,
                  animationDuration: 1500,
                  animation: true,
                  progressColor: Theme.of(context).accentColor,
                  addAutomaticKeepAlive: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  footer: Text(
                    e.first,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(
        24,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const ListTile(
          title: SelectableText(
            'About Me',
            textScaleFactor: 2,
            toolbarOptions: ToolbarOptions(
              copy: true,
              selectAll: true,
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        const ListTile(
          title: Text(
            'I.T. admin by day. Flutter enthusiast by night.',
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Wrap(
          runAlignment: WrapAlignment.spaceAround,
          alignment: WrapAlignment.spaceAround,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 16,
          children: [
            ['Dart', 'https://dart.dev/'],
            ['Flutter', 'https://flutter.dev/'],
            ['C++', 'https://isocpp.org/'],
            ['Python', 'https://www.python.org/'],
          ]
              .map(
                (e) => FloatingActionButton.extended(
                  highlightElevation: 2,
                  elevation: 2,
                  tooltip: 'Visit ${e.first} homepage',
                  shape: const StadiumBorder(),
                  onPressed: () async {
                    if (await canLaunch(e.last)) {
                      await launch(e.last);
                    }
                  },
                  label: Text(e.first),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class ProjectShowCase extends StatelessWidget {
  const ProjectShowCase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          child: Text(
            'Project Showcase',
            textScaleFactor: 2,
          ),
        ),
        const SizedBox(
          height: 64,
        ),
        Wrap(
          runAlignment: WrapAlignment.spaceEvenly,
          alignment: WrapAlignment.spaceEvenly,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            [
              'FlyX',
              'Flight booking website',
              'https://flyx.io/',
            ],
            [
              'Bmi Calculator',
              'Simple Bmi Calculator',
              'https://maheshwarravuri.com/bmicalc/'
            ],
          ]
              .map(
                (e) => ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 125,
                    maxWidth: 500,
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          e.first,
                          textScaleFactor: 2,
                        ),
                        subtitle: Text(
                          e.elementAt(1),
                        ),
                        trailing: IconButton(
                          tooltip: 'Vist ${e.first}',
                          icon: Icon(
                            Icons.open_in_new,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () async {
                            if (await canLaunch(e.last)) {
                              await launch(e.last);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
