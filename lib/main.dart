import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async => Hive.initFlutter()
    .whenComplete(
      () async => Hive.openBox(
        'darkMode',
      ),
    )
    .whenComplete(WidgetsFlutterBinding.ensureInitialized)
    .whenComplete(
      () => runApp(
        const Center(
          child: Text('Hi...'),
        ),
      ),
    );
