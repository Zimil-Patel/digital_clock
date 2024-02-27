import 'dart:async';
import 'package:intl/intl.dart';
import 'package:digital_clock/colors/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({super.key});

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

late double height, width;
DateTime dateTime = DateTime.now();

var date = DateTime.now();

class _DigitalClockState extends State<DigitalClock> {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    //print(DateFormat('EE').format(dateTime)); // prints Tuesday

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        dateTime = DateTime.now();
      });
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Row(children: [
        // hours and minutes
        hoursAndMinute(),

        //other stuffs
        rightStuffs(),
      ])),
    );
  }

  hoursAndMinute() {
    return Expanded(
      flex: 5,
      child: Container(
        alignment: Alignment.center,
        height: height,
        child: Text(
          '${dateTime.hour % 12 < 10 ? '0${dateTime.hour % 12}' : dateTime.hour % 12} : ${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}',
          style: GoogleFonts.varelaRound(
              textStyle: TextStyle(
                  fontSize: width / 4,
                  color: timeColor,
                  letterSpacing: -20,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  rightStuffs() {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //top stuff
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  showDayDate(
                      day: DateFormat('EE').format(dateTime), color: timeColor),
                  showDayDate(day: ' ${dateTime.day}'),
                ])),

                //temperature
                const Text(
                  '26°',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          //bottom stuff
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //alaram icon
                Icon(
                  Icons.alarm_on_rounded,
                  size: 40,
                  color: timeColor,
                ),

                const SizedBox(
                  height: 20,
                ),

                //second and AM/PM
                RichText(
                    text: TextSpan(children: [
                  showDayDate(
                      day:
                          '${dateTime.second < 10 ? '0${dateTime.second}' : dateTime.second} '),
                  showDayDate(day: 'sec  ', size: 16),
                  showDayDate(
                      day: dateTime.hour < 12 ? 'AM' : 'PM',
                      color: timeColor,
                      size: 16),
                ])),
              ],
            ),
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
                fontSize: size ?? 40,
                color: color ?? Colors.white,
                fontWeight: FontWeight.w600)));
  }
}
