import 'package:digital_clock/screens/analog_clock.dart';
import 'package:digital_clock/screens/digital_clock.dart';
import 'package:digital_clock/screens/stop_watch.dart';
import 'package:digital_clock/screens/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //routes
        debugShowCheckedModeBanner: false,
        initialRoute: '/analog',
        routes: {
          '/clock': (context) => const DigitalClock(),
          '/analog': (context) => const Analog(),
          '/timer': (context) => const TimerApp(),
          '/stop': (context) => const StopWatch(),
        });
  }
}
