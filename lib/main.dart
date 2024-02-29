import 'package:digital_clock/screens/analog_clock.dart';
import 'package:digital_clock/screens/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  runApp(MaterialApp(
      //routes
      debugShowCheckedModeBanner: false,
      initialRoute: '/analog',
      routes: {
        '/clock': (context) => const DigitalClock(),
        '/analog': (context) => const Analog(),
      }));
}
