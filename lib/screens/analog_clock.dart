import 'dart:async';
import 'dart:math';
import 'package:analog_clock/analog_clock.dart';
import 'package:intl/intl.dart';
import 'package:digital_clock/colors/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Analog extends StatefulWidget {
  const Analog({super.key});

  @override
  State<Analog> createState() => _AnalogState();
}

late double height, width;
DateTime dateTime = DateTime.now();

var date = DateTime.now();

class _AnalogState extends State<Analog> {
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
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
        shape: BoxShape.circle,
        border: Border.all(color: timeColor, width: 4),
      ),
      child: Stack(
        children: [
          AnalogClock(
            tickColor: Colors.transparent,
            numberColor: timeColor,
            showAllNumbers: true,
            showSecondHand: false,
            showDigitalClock: false,
            showTicks: true,
          ),

          ...List.generate(
            60,
            (index) => Center(
              child: Transform.rotate(
                angle: index * 6 * pi / 180,
                child: VerticalDivider(
                  color: (index % 5 == 0) ? timeColor : Colors.white,
                  thickness: (index % 5 == 0) ? 4 : 1,
                  indent: (index % 5 == 0) ? 285 : 288,
                ),
              ),
            ),
          ),

          //seconds
          Center(
            child: Transform.rotate(
              angle: dateTime.second * 6 * pi / 180,
              child: VerticalDivider(
                color: Colors.white.withOpacity(0.2),
                thickness: 5,
                indent: 58,
                endIndent: 128,
              ),
            ),
          ),

          // //minutes
          Center(
            child: Transform.rotate(
              angle: (dateTime.minute * 6 * pi / 180),
              child: VerticalDivider(
                color: Colors.white.withOpacity(0.4),
                thickness: 5,
                indent: 74,
                endIndent: 128,
              ),
            ),
          ),

          // //hours
          Center(
            child: Transform.rotate(
              angle: (dateTime.hour * 30 * pi / 180) +
                  (dateTime.minute * 0.5 * pi / 180),
              child: VerticalDivider(
                color: Colors.white.withOpacity(0.6),
                thickness: 5,
                indent: 90,
                endIndent: 128,
              ),
            ),
          ),

          const Center(
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  rightStuffs() {
    return Column(
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
              SizedBox(
                height: 50,
                width: 100,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.of(context).pushNamed('/timer');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.alarm_on_rounded,
                        size: 40,
                        color: timeColor,
                      ),
                      Text(' Timer',
                          style: GoogleFonts.varelaRound(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )),
                    ],
                  ),
                ),
              ),

              //stopwatch icon
              SizedBox(
                height: 50,
                width: 150,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.of(context).pushNamed('/stop');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later_sharp,
                        size: 40,
                        color: timeColor,
                      ),
                      Text(' StopWatch',
                          style: GoogleFonts.varelaRound(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          )),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //second and AM/PM
              RichText(
                  text: TextSpan(children: [
                showDayDate(
                    color: timeColor,
                    day:
                        '${dateTime.hour % 12 < 10 ? '0${dateTime.hour % 12}' : dateTime.hour % 12} : ${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}\n${dateTime.second < 10 ? '0${dateTime.second}' : dateTime.second}'),
                showDayDate(
                    day: dateTime.hour < 12 ? '  AM' : '  PM', size: 16),
              ])),
            ],
          ),
        ),
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
}
