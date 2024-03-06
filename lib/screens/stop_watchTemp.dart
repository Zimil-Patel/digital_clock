//ignore this dar file

import 'dart:async';

import 'package:digital_clock/colors/digital_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

late double height, width;

class _StopWatchState extends State<StopWatch> {
  bool isRunning = false;
  int sec = 0;

  String formattedTime() {
    String s = (sec % 60).toString().padLeft(2, '0');
    String m = ((sec ~/ 60) % 60).toString().padLeft(2, '0');
    String h = (((sec ~/ 60) ~/ 60)).toString().padLeft(2, '0');

    return '$h : $m : $s';
  }

  void startStop() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      if (isRunning) {
        sec++;
      }

      setState(() {});
    });

    if (isRunning) {
      startStop();
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,

        //appbar of the screen
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: timeColor),
          backgroundColor: Colors.transparent,
          title: Text(
            'Stop Watch',
            style: TextStyle(
              color: timeColor,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        //body of the screen
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //stopwatch design
              CupertinoButton(
                onPressed: () {
                  if (isRunning) {
                    isRunning = false;
                  } else {
                    isRunning = true;
                    startStop();
                  }
                },
                padding: const EdgeInsets.all(0),
                child: Container(
                  height: height / 1.3,
                  width: height / 1.3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      width: 0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 15, spreadRadius: 2, color: Colors.white)
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //stopwatch time
                      Text(
                        formattedTime(),
                        style: TextStyle(
                          color: timeColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //start stop text
                      Text(false ? 'Stop' : 'Start',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              color: Colors.red.shade100,
                              fontSize: 20,
                            ),
                          )),
                    ],
                  ),
                ),
              ),

              CupertinoButton(
                onPressed: () {
                  sec = 0;
                  setState(() {});
                },
                child: Text('Reset',
                    style: GoogleFonts.varelaRound(
                      textStyle: TextStyle(
                        color: Colors.red.shade100,
                        fontSize: 28,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
