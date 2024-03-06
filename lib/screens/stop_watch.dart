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
  late Stopwatch stopWatch;
  late Timer t;

  @override
  void initState() {
    super.initState();
    stopWatch = Stopwatch();

    t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  //start and stop handler
  startStop() {
    if (stopWatch.isRunning) {
      stopWatch.stop();
    } else {
      stopWatch.start();
    }
  }

  //formattig time in string
  String getFormattedTime() {
    var mili = stopWatch.elapsed.inMilliseconds;

    String miliSec = (mili % 1000).toString().padLeft(3, '0');
    String sec = ((mili ~/ 1000) % 60).toString().padLeft(2, '0');
    String min = ((mili ~/ 1000) ~/ 60).toString().padLeft(2, '0');

    return "$min:$sec:$miliSec";
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
            style: GoogleFonts.varelaRound(
              textStyle: TextStyle(
                color: timeColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
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
                  startStop();
                },
                padding: const EdgeInsets.all(0),
                child: Container(
                  margin: const EdgeInsets.all(30),
                  height: 300,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      width: 0,
                    ),
                    boxShadow: [
                      stopWatch.isRunning
                          ? boxshadow(Colors.red)
                          : boxshadow(timeColor),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //stopwatch time
                      Text(
                        getFormattedTime(),
                        style: TextStyle(
                          color: timeColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //start stop text
                      Text(stopWatch.isRunning ? 'Stop' : 'Start',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              color: Colors.red.shade100,
                              fontSize: 16,
                            ),
                          )),
                    ],
                  ),
                ),
              ),

              CupertinoButton(
                onPressed: () {
                  stopWatch.reset();
                },
                child: Text('Reset',
                    style: GoogleFonts.varelaRound(
                      textStyle: TextStyle(
                        color: Colors.red.shade100,
                        fontSize: 26,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  boxshadow(Color color) {
    return BoxShadow(
      offset: const Offset(8, 8),
      blurRadius: 20,
      spreadRadius: 0.001,
      color: color.withOpacity(0.2),
    );
  }
}
