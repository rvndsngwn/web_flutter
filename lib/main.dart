import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Brightness, TextInputType;
import 'package:flutter_icons/flutter_icons.dart'
    show FontAwesome, FontAwesome5Brands;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart' show Hive;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:percent_indicator/linear_percent_indicator.dart'
    show LinearPercentIndicator, LinearStrokeCap;
import 'package:string_validator/string_validator.dart'
    show isEmail, isLength, isNumeric, normalizeEmail, stripLow, toString;
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;
import 'package:dio/dio.dart' show Dio;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'layout/responsive_helper.dart';

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
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Hive.box('darkMode').listenable(),
        builder: (_, box, __) {
          final _isDarkMode = box.get('darkMode', defaultValue: true);
          return MaterialApp(
            themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark().copyWith(
              accentColor: const Color(0xffFCCFA8),
              textSelectionColor: const Color(0xffFCCFA8),
              cursorColor: const Color(0xffFCCFA8),
              textTheme: GoogleFonts.comfortaaTextTheme(
                ThemeData(
                  primarySwatch: Colors.teal,
                  brightness: Brightness.dark,
                ).textTheme,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            theme: ThemeData.light().copyWith(
              textTheme: GoogleFonts.comfortaaTextTheme(),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Scaffold(
              body: const Center(
                child: HomePage(),
              ),
              floatingActionButton: Builder(
                builder: (context) => RaisedButton(
                  mouseCursor: MaterialStateMouseCursor.clickable,
                  color: Theme.of(context).accentColor,
                  colorBrightness: Brightness.dark,
                  shape: const CircleBorder(),
                  onPressed: () => box.put('darkMode', !_isDarkMode),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      _isDarkMode ? FontAwesome.sun_o : FontAwesome.moon_o,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  int selected = 0;
  @override
  void initState() {
    super.initState();
  }

  static final List<Widget> _content = [
    Card(
      shape: const CircleBorder(),
      margin: const EdgeInsets.all(12),
      child: Image.asset(
        'assets/images/Profile.png',
        isAntiAlias: true,
        gaplessPlayback: true,
        frameBuilder:
            (_, Widget child, int frame, bool wasSynchronouslyLoaded) {
          return wasSynchronouslyLoaded
              ? child
              : AnimatedOpacity(
                  opacity: 1,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeOut,
                  child: child,
                );
        },
      ),
    ),
    const Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Info(),
    ),
    Image.asset(
      'assets/images/svg.png',
      width: 436,
      isAntiAlias: true,
      gaplessPlayback: true,
      frameBuilder: (_, Widget child, int frame, bool wasSynchronouslyLoaded) {
        return wasSynchronouslyLoaded
            ? child
            : AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeOut,
                child: child,
              );
      },
    ),
    const Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: AboutMe(),
    ),
    const ProjectShowCase(),
    ...[
      const TechnicalSkills(),
      const ContactMe(),
    ]
        .map(
          (e) => Card(
            elevation: 2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: e,
          ),
        )
        .toList(),
    Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Text(
            '© ${DateTime.now().year} Maheshwar Ravuri. All rights reserved.'),
      ),
    )
  ]
      .map(
        (x) => SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: x,
          ),
        ),
      )
      .toList();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // if (isMobile(context))
        NavigationRail(
          selectedIndex: selected,
          onDestinationSelected: (i) {
            setState(() {
              selected = i;
            });

            itemScrollController.scrollTo(
                index: 3 + i,
                duration: const Duration(
                  milliseconds: 350,
                ),
                curve: Curves.easeInOut);
          },
          groupAlignment: 0,
          unselectedLabelTextStyle: const TextStyle(color: Colors.black),
          labelType: NavigationRailLabelType.all,
          backgroundColor: Theme.of(context).accentColor,
          selectedLabelTextStyle: TextStyle(
              color: Theme.of(context).accentColor,
              backgroundColor: Colors.black54),
          minWidth: isMobile(context) ? 52 : 72,
          destinations: const ['About Me', 'Projects', 'Skills', 'Contact']
              .map(
                (x) => NavigationRailDestination(
                  label: RotatedBox(
                    quarterTurns: 3,
                    child: Text(x),
                  ),
                  icon: const SizedBox.shrink(),
                ),
              )
              .toList(),
        ),
        AnimationLimiter(
          child: Expanded(
            child: Scrollbar(
              child: Center(
                child: ScrollablePositionedList.builder(
                  itemCount: _content.length,
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      horizontalOffset: -100,
                      duration: const Duration(seconds: 1),
                      child: FadeInAnimation(
                        duration: const Duration(seconds: 1),
                        child: Align(
                          child: SizedBox(
                            width: 500,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: _content.elementAt(index),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Info extends StatelessWidget {
  const Info({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        children: [
          Align(
            child: RaisedButton(
              disabledColor: Theme.of(context).accentColor,
              shape: const StadiumBorder(),
              highlightElevation: 2,
              elevation: 0,
              onPressed: null,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Hello I'm",
                  style: TextStyle(color: Colors.black),
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListTile(
            leading: Icon(Icons.account_circle,
                color: Theme.of(context).accentColor),
            title: const SelectableText(
              'Maheshwar Ravuri',
              textScaleFactor: 1,
              toolbarOptions: ToolbarOptions(
                copy: true,
                selectAll: true,
              ),
            ),
            subtitle: const Text(
              'Mobile Developer',
            ),
          ),
          ...[
            [
              Icon(Icons.location_on, color: Theme.of(context).accentColor),
              'Fresno, CA, United States',
            ],
            [
              Icon(Icons.email, color: Theme.of(context).accentColor),
              'maheshwar.ravuri@gmail.com',
            ],
            [
              Icon(Icons.phone, color: Theme.of(context).accentColor),
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
              [
                FontAwesome5Brands.twitter,
                'https://twitter.com/MaheshwarRavuri'
              ]
            ]
                .map(
                  (e) => Tooltip(
                    message: 'Visit ${e.last}',
                    child: RaisedButton(
                      mouseCursor: MaterialStateMouseCursor.clickable,
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

class AboutMe extends StatelessWidget {
  const AboutMe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const ListTile(
            title: SelectableText(
              'About Me',
              textScaleFactor: 1.5,
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
                  (e) => Tooltip(
                    message: 'Visit ${e.first} homepage',
                    child: RaisedButton(
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      color: Theme.of(context).accentColor,
                      highlightElevation: 2,
                      elevation: 2,
                      shape: const StadiumBorder(),
                      onPressed: () async {
                        if (await canLaunch(e.last)) {
                          await launch(e.last);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          e.first,
                          style: const TextStyle(color: Colors.black),
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

class ProjectShowCase extends StatelessWidget {
  const ProjectShowCase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Align(
            child: Text(
              'Project Showcase',
              textScaleFactor: 1.5,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Wrap(
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 32,
            spacing: 64,
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
                'https://www.maheshwarravuri.com/bmicalc/#/'
              ],
              [
                'IPTV-Viewer',
                'Watch 8000+ publicly available IPTV channels within your browser',
                'http://www.maheshwarravuri.com/IPTV-Viewer/'
              ],
              [
                'VR Planetarium',
                'Modernized the planetarium experience using virtual reality',
                'https://store.steampowered.com/app/1313970/PlanetariumVR/'
              ],
            ]
                .map(
                  (e) => ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 125,
                      maxWidth: 500,
                    ),
                    child: Tooltip(
                      message: 'Visit ${e.first}',
                      child: InkWell(
                        mouseCursor: MaterialStateMouseCursor.clickable,
                        onTap: () async {
                          if (await canLaunch(e.last)) {
                            await launch(e.last);
                          }
                        },
                        hoverColor: Theme.of(context).accentColor,
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                e.first,
                                textScaleFactor: 1.5,
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  e.elementAt(1),
                                ),
                              ),
                              trailing: Icon(
                                Icons.open_in_new,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
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

class TechnicalSkills extends StatelessWidget {
  const TechnicalSkills({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        children: [
          const Align(
            child: Text(
              'Technical Skills',
              textScaleFactor: 1.5,
            ),
          ),
          const SizedBox(
            height: 16,
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
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                ),
              )
              .toList(),
        ],
      );
}

class ContactMe extends StatefulWidget {
  const ContactMe({Key key}) : super(key: key);

  @override
  _ContactMeState createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  final _formKey = GlobalKey<FormState>();
  String name, phone, email, details;

  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Align(
            child: Text(
              'Contact Me',
              textScaleFactor: 1.5,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Name cannot be empty' : null,
                  onChanged: (value) => setState(() {
                    name = value.trim();
                  }),
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => setState(
                    () {
                      if (isNumeric(value)) {
                        phone = value;
                      }
                    },
                  ),
                  validator: (value) => !isNumeric(value)
                      ? 'Invalid PhoneNumber'
                      : !isLength(value, 4, 22) ? 'Invalid PhoneNumber' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) => value.isEmpty
                      ? 'Email cannot be empty'
                      : !isEmail(value) ? 'Invalid Email' : null,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => setState(
                    () {
                      if (isEmail(value)) {
                        email = toString(normalizeEmail(value)).trim();
                      }
                    },
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    labelText: 'Message',
                    helperMaxLines: 7,
                    hintMaxLines: 7,
                    prefixIcon: Icon(Icons.speaker_notes),
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Description cannot be empty' : null,
                  onChanged: (value) => setState(
                      () => details = stripLow(toString(value)).trim()),
                  keyboardType: TextInputType.multiline,
                  maxLines: 7,
                ),
                Center(
                  child: Tooltip(
                    message: 'Submit Details',
                    child: RaisedButton.icon(
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      elevation: 2,
                      shape: const StadiumBorder(),
                      highlightElevation: 4,
                      color: Theme.of(context).accentColor,
                      icon: const Icon(Icons.send, color: Colors.black),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final _timestamp = DateFormat('yMMMd')
                              .add_jms()
                              .format(
                                DateTime.now(),
                              )
                              .trim();
                          final _ipData = '?name='
                              '$name'
                              '&phone=$phone'
                              '&email=$email'
                              '&details=$details'
                              '&timestamp=$_timestamp';
                          const url =
                              'https://script.google.com/macros/s/AKfycbyQNVoxSjwWskTGpjO5ad11syVkcC3y-WLmalFsBn_8ujeFV3-B/exec';

                          try {
                            await Dio()
                                .get(
                                  url + _ipData,
                                )
                                .then(
                                  (value) => value.statusCode == 200
                                      ? Scaffold.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Submission Recevied',
                                            ),
                                          ),
                                        )
                                      : Scaffold.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Insufficient information provided',
                                            ),
                                          ),
                                        ),
                                );
                          } on Exception catch (e) {
                            Exception(e);
                          }
                        }
                      },
                      label: const Padding(
                        padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                        child: Text(
                          'Send',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
                  .map(
                    (e) => Padding(padding: const EdgeInsets.all(8), child: e),
                  )
                  .toList(),
            ),
          )
        ],
      );
}
