import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/Annuncio.dart';

class AnnuncioWidget extends StatelessWidget {
  static const PRIORITY2COLOR = {
    Annuncio.URGENT: Color(0xffFF8E8E),
    Annuncio.ALERT: Color(0xffFFE38E),
    Annuncio.INFO: Color(0xff8EB7FF)
  };
  static const SHORT_ITA_MONTHS = [
    '',
    'gen',
    'feb',
    'mar',
    'apr',
    'mag',
    'giu',
    'lug',
    'ago',
    'set',
    'ott',
    'nov',
    'dic'
  ];

  final Annuncio annuncio;

  AnnuncioWidget(this.annuncio);

  static String FORMAT_DATETIME(DateTime datetime) {
    String result = '';
    result += datetime.day.toString();
    result += ' ';
    result += AnnuncioWidget.SHORT_ITA_MONTHS[datetime.month];
    if (DateTime.now().year != datetime.year)
      result += ' ' + datetime.year.toString();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Card(
            color: PRIORITY2COLOR[this.annuncio.priority],
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(children: [
                  SizedBox(
                      width: double.infinity,
                      child: Text(annuncio.text,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xff444444), fontSize: 16))),
                  SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                          FORMAT_DATETIME(annuncio.datetime) +
                              ', ' +
                              annuncio.author,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Color(0xff444444))))
                ]))));
  }
}
