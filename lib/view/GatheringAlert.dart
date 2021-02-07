import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Mediator.dart';

class GatheringAlert extends StatefulWidget {
  final Mediator mediator;

  GatheringAlert(this.mediator);

  @override
  _GatheringAlertState createState() => _GatheringAlertState();
}

class _GatheringAlertState extends State<GatheringAlert> {
  final TextEditingController oneTimeIdController = TextEditingController();
  Timer _timer;
  int _start = 10;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEF5350),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Text(
                  'Mantieni il distanziamento',
                  style:
                  GoogleFonts.montserrat(fontSize: 40, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Text(
                  'Segnalazione assembramento entro',
                  style:
                  GoogleFonts.montserrat(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 90),
                Text(
                  _start.toString() + ' secondi',
                  style:
                      GoogleFonts.montserrat(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            )));
  }
}
