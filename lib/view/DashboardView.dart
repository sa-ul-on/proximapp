import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proximapp/util/FormUtils.dart';

import '../Mediator.dart';
import '../server/worktimews/Worktime.dart';
import '../widget/AppBarMaker.dart';
import '../widget/MenuWidget.dart';

class DashboardView extends StatefulWidget {
  final Mediator mediator;

  // Map<String, List<Worktime>> worktimes;
  List<String> days;
  List<List<Worktime>> worktimes;

  DashboardView(this.mediator, this.days, this.worktimes);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool activeWorktimeButton;
  Color worktimeButtonColor;
  String worktimeButtonText;

  @override
  void initState() {
    super.initState();
    activeWorktimeButton = true;
    if (widget.mediator.isWorktimeOpen()) {
      setOpenWorktimeUI();
    } else {
      setCloseWorktimeUI();
    }
  }

  void setOpenWorktimeUI() {
    worktimeButtonText = 'Smetti di lavorare';
    worktimeButtonColor = Color(0xdd7daddc);
  }

  void setCloseWorktimeUI() {
    worktimeButtonText = 'Comincia a lavorare';
    worktimeButtonColor = Color(0xff6d9eeb);
  }

  void onClick() async {
    setState(() {
      activeWorktimeButton = false;
    });
    if (widget.mediator.isWorktimeOpen()) {
      bool res = await widget.mediator.closeWorktime();
      if (res) {
        setState(() {
          setCloseWorktimeUI();
        });
      } else {
        FormUtils.showToast(
            'Non è possibile effettuare questa operazione al momento',
            context,
            5);
      }
    } else {
      bool res = await widget.mediator.openWorktime();
      if (res) {
        setState(() {
          setOpenWorktimeUI();
        });
      } else {
        FormUtils.showToast(
            'Non è possibile effettuare questa operazione al momento',
            context,
            5);
      }
    }
    setState(() {
      activeWorktimeButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar(''),
        drawer: MenuWidget(widget.mediator),
        backgroundColor: Color(0xfff5f5f5),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                            child: Text(worktimeButtonText,
                                style: GoogleFonts.montserrat(
                                    fontSize: 28, color: Colors.white)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            color: worktimeButtonColor,
                            disabledColor: Color(0xff999999),
                            onPressed: activeWorktimeButton ? onClick : null)),
                    SizedBox(height: 10),
                    ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: widget.worktimes.length,
                        itemBuilder: (context, i) {
                          String day = widget.days[i];
                          List<Worktime> wts = widget.worktimes[i];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Card(
                                  color: Color(0xffdddddd),
                                  child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(day,
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.montserrat(
                                                  textStyle:
                                                      TextStyle(fontSize: 18))),
                                          SizedBox(height: 10),
                                          ListView.builder(
                                            primary: false,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: wts.length,
                                            itemBuilder: (context, index) {
                                              Worktime wt = wts[index];
                                              String from =
                                                  wt.dateFrom.hour.toString() +
                                                      ':' +
                                                      wt.dateFrom.minute
                                                          .toString()
                                                          .padLeft(2, '0');
                                              String to =
                                                  wt.dateTo.hour.toString() +
                                                      ':' +
                                                      wt.dateTo.minute
                                                          .toString()
                                                          .padLeft(2, '0');
                                              int hourDuration = wt.dateTo
                                                  .difference(wt.dateFrom)
                                                  .inHours;
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(from + ' - ' + to,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                textStyle:
                                                                    TextStyle(
                                                                        fontSize:
                                                                            15))),
                                                    Text(
                                                        hourDuration
                                                                .round()
                                                                .toString() +
                                                            'h',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                textStyle:
                                                                    TextStyle(
                                                                        fontSize:
                                                                            15)))
                                                  ]);
                                              /*return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10),
                                                  child: Text(text,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          textStyle:
                                                          TextStyle(
                                                              fontSize:
                                                              18))));*/
                                            },
                                          ),
                                        ],
                                      )))
                            ],
                          );
                        })
                  ],
                ))));
  }
}
