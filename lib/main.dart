import 'package:flutter/material.dart'
    show
        Align,
        AnimatedOpacity,
        Axis,
        BorderRadius,
        BouncingScrollPhysics,
        BoxConstraints,
        BuildContext,
        ButtonBar,
        Card,
        Center,
        CircleBorder,
        Column,
        ConstrainedBox,
        Curves,
        EdgeInsets,
        FloatingActionButton,
        Form,
        FormState,
        GlobalKey,
        Icon,
        IconButton,
        IconTheme,
        Icons,
        Image,
        InputDecoration,
        Key,
        ListTile,
        ListView,
        MaterialApp,
        NeverScrollableScrollPhysics,
        OutlineInputBorder,
        Padding,
        Radius,
        RaisedButton,
        RoundedRectangleBorder,
        Scaffold,
        Scrollbar,
        SelectableText,
        SizedBox,
        SnackBar,
        StadiumBorder,
        State,
        StatefulWidget,
        StatelessWidget,
        Text,
        TextFormField,
        TextInputType,
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
import 'package:flutter/services.dart' show TextInputType;
import 'package:flutter_icons/flutter_icons.dart'
    show FontAwesome, FontAwesome5Brands;
import 'package:hive/hive.dart' show Hive;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:percent_indicator/linear_percent_indicator.dart'
    show LinearPercentIndicator, LinearStrokeCap;
import 'package:string_validator/string_validator.dart'
    show isEmail, isLength, isNumeric, normalizeEmail, stripLow, toString;
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;
import 'package:dio/dio.dart' show Dio;

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
        padding: const EdgeInsets.symmetric(horizontal: 4),
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
            runSpacing: 64,
            spacing: 64,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.asset(
                'assets/images/Profile.png',
                width: 436,
                isAntiAlias: true,
                frameBuilder:
                    (_, Widget child, int frame, bool wasSynchronouslyLoaded) {
                  return wasSynchronouslyLoaded
                      ? child
                      : AnimatedOpacity(
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOut,
                          child: child,
                        );
                },
              ),
              const SizedBox(
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
                width: 436,
                isAntiAlias: true,
                frameBuilder:
                    (_, Widget child, int frame, bool wasSynchronouslyLoaded) {
                  return wasSynchronouslyLoaded
                      ? child
                      : AnimatedOpacity(
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOut,
                          child: child,
                        );
                },
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
          const SizedBox(
            height: 64,
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
                    cut: true,
                  ),
                ),
              ),
            )
            .toList(),
        ButtonBar(
          children: [
            [FontAwesome5Brands.github, 'https://github.com/Mravuri86'],
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

class ProfessionalSkills extends StatefulWidget {
  const ProfessionalSkills({Key key}) : super(key: key);

  @override
  _ProfessionalSkillsState createState() => _ProfessionalSkillsState();
}

class _ProfessionalSkillsState extends State<ProfessionalSkills> {
  final _formKey = GlobalKey<FormState>();
  String name, phone, email, message;

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
            'Contact Me',
            textScaleFactor: 2,
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
                onChanged: (value) => setState(() {
                  message = stripLow(toString(value)).trim();
                }),
                keyboardType: TextInputType.multiline,
                maxLines: 7,
              ),
              Center(
                child: FloatingActionButton.extended(
                  elevation: 2,
                  highlightElevation: 4,
                  tooltip: 'Submit Details',
                  hoverElevation: 4,
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      final _timestamp =
                          DateFormat('yMMMd').add_jms().format(DateTime.now());
                      final _ipData = '?name='
                          '$name'
                          '&phone=$phone'
                          '&email=$email'
                          '&Message=$message'
                          '&timestamp=${_timestamp.trim()}';
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
                  label: const Text('Send'),
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
}
