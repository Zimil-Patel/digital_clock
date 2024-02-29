import 'dart:async';
import 'dart:math';

import 'package:analog_clock/analog_clock.dart';
import 'package:digital_clock/colors/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  State<TimerApp> createState() => _TimerAppState();
}

late double height, width;
DateTime dateTime = DateTime.now();
int min = 0, sec = 0;

var date = DateTime.now();

class _TimerAppState extends State<TimerApp> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    //print(DateFormat('EE').format(dateTime)); // prints Tuesday

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        dateTime = DateTime.now();
        sec += 1;
      });
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Row(children: [
          // hours and minutes
          analog(),

          const Spacer(),

          //other stuffs
          rightStuffs(),
        ])),
      ),
    );
  }

  analog() {
    return Expanded(
      flex: 4,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: timeColor, width: 5),
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
            ...List.generate(
              60,
              (index) => Center(
                child: Transform.rotate(
                  angle: index * 6 * pi / 180,
                  child: VerticalDivider(
                    color: (index % 5 == 0) ? timeColor : Colors.white,
                    thickness: (index % 5 == 0) ? 4 : 1,
                    indent: (index % 5 == 0) ? height / 1.11 : height / 1.11,
                  ),
                ),
              ),
            ),

            //arrow back button
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: timeColor,
                  size: 30,
                ),
              ),
            ),

            //circular progress bar
            Center(
              child: SizedBox(
                height: height / 1.1,
                width: width / 2.4,
                child: CircularProgressIndicator(
                  color: timeColor,
                  strokeWidth: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  rightStuffs() {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //timer counter
          RichText(
              text: TextSpan(children: [
            showDayDate(
                color: timeColor,
                day:
                    '${min < 10 ? '0$min' : min} : ${sec < 10 ? '0$sec' : sec}'),
          ])),

          //top stuff
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                showDayDate(
                    day: DateFormat('EE').format(dateTime), color: timeColor),
                showDayDate(day: ' ${dateTime.day}'),
              ])),

              const SizedBox(
                height: 20,
              ),

              //second and AM/PM
              RichText(
                  text: TextSpan(children: [
                showDayDate(
                    color: timeColor,
                    day:
                        '${dateTime.hour % 12 < 10 ? '0${dateTime.hour % 12}' : dateTime.hour % 12} : ${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute} : ${dateTime.second < 10 ? '0${dateTime.second}' : dateTime.second}'),
                showDayDate(
                    day: dateTime.hour < 12 ? '  AM' : '  PM', size: 16),
              ])),
            ],
          ),
        ],
      ),
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
}
