import 'dart:async';
import 'dart:math';

import 'package:analog_clock/analog_clock.dart';
import 'package:digital_clock/colors/digital_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  State<TimerApp> createState() => _TimerAppState();
}

late double height, width;

class _TimerAppState extends State<TimerApp> {
  int minutes = 1;
  late int second = (minutes * 60);
  bool isRunning = false;

  void startStop() async {
    if (isRunning) {
      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          second--;
        });
      });

      if (isRunning) {
        if (second > 0) {
          startStop();
        } else {
          isRunning = false;
          setState(() {
            second = minutes * 60;
          });
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: timeColor),
          backgroundColor: Colors.transparent,
          title: Text(
            'Timer',
            style: GoogleFonts.varelaRound(
              textStyle: TextStyle(
                color: timeColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              // hours and minutes
              analog(),

              //other stuffs
              rightStuffs(),
            ])),
      ),
    );
  }

  analog() {
    return Container(
      height: 300,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          width: 0,
        ),
        boxShadow: [
          boxshadow(timeColor),
        ],
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          //analog clock text/ numbers
          AnalogClock(
            tickColor: Colors.transparent,
            numberColor: timeColor,
            showAllNumbers: true,
            showSecondHand: false,
            showDigitalClock: false,
            showTicks: true,
            hourHandColor: Colors.transparent,
            minuteHandColor: Colors.transparent,
          ),

          //circular progress bar
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 300,
                width: 300,
                child: CircularProgressIndicator(
                  value: second / (60 * minutes),
                  color: timeColor,
                  strokeWidth: 6,
                ),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$minutes min Timer',
                    style: GoogleFonts.varelaRound(
                      textStyle: TextStyle(
                          color: Colors.red.shade100,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),

                //start button
                CupertinoButton(
                  onPressed: () {
                    if (isRunning) {
                      isRunning = false;
                      startStop();
                    } else {
                      isRunning = true;
                      startStop();
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: timeColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      isRunning ? 'Stop' : 'Start',
                      style: GoogleFonts.varelaRound(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  rightStuffs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addBtn(1),
        addBtn(5),
        addBtn(10),
        addBtn(20),
        addBtn(30),
      ],
    );
  }

  showDayDate({required String day, Color? color, double? size}) {
    return TextSpan(
        text: day,
        style: GoogleFonts.varelaRound(
            textStyle: TextStyle(
                fontSize: size ?? 30,
                color: color ?? Colors.white,
                fontWeight: FontWeight.w600)));
  }

  addNum(int index) {
    return (
      '$index',
      style: TextStyle(color: timeColor, fontSize: height / 20),
    );
  }

  addBtn(int min) {
    return CupertinoButton(
        child: Container(
          width: 100,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: timeColor,
            borderRadius: BorderRadiusDirectional.circular(5),
          ),
          child: Text('$min minutes',
              style: GoogleFonts.varelaRound(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              )),
        ),
        onPressed: () {
          setState(() {
            minutes = min;
            second = minutes * 60;
          });
        });
  }

// void checkState() {
//   setState(() {
//     sec++;
//     dateTime = DateTime.now();
//   });
// }

  boxshadow(Color color) {
    return BoxShadow(
      offset: const Offset(8, 8),
      blurRadius: 20,
      spreadRadius: 0.001,
      color: color.withOpacity(0.2),
    );
  }
}
