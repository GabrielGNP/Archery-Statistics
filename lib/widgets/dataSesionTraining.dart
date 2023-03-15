import 'package:flutter/material.dart';

import '../MetaData.dart';
import '../models/TrainingSesion.dart';
import '../models/widgetRound.dart';

class DataSesionTraining extends StatefulWidget {
  List<WidgetRound> widgetRounds;
  String typeSesion;

  DataSesionTraining({required this.widgetRounds, required this.typeSesion});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DataSesionTrainingState();
  }
}

class _DataSesionTrainingState extends State<DataSesionTraining> {
  int numberShotsArrow = 0;
  int numberRounds = 0;
  int points = 0;
  var values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  _reLoadState(bool active) {
    _calculateData();

    if (active) {
      setState(() {
        print("cosas");
      });
    }
  }

  _calculateData() {
    values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    points = 0;
    numberShotsArrow = 0;
    numberRounds = widget.widgetRounds.length;
    widget.widgetRounds.forEach((round) {
      round.valuesInRound.forEach((value) {
        if (value >= 0) {
          points = points + value;
        }
        values[value + 1] = values[value + 1] + 1;
      });
      numberShotsArrow = numberShotsArrow + round.valuesInRound.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reLoadStateDST = _reLoadState;
    _calculateData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            border: Border(
              top: BorderSide(color: Colors.green, width: 1),
              left: BorderSide(color: Colors.green, width: 1),
              right: BorderSide(color: Colors.green, width: 1),
              bottom: BorderSide(color: Colors.green, width: 1),
            )),
        child: _generateData());
  }

  Widget _generateData() {
    if (widget.typeSesion == "Points") {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Number Arrow Shots: $numberShotsArrow",
                  style: TextStyle(fontSize: 17),
                ),
                Spacer(),
                Text(
                  "Number Rounds: $numberRounds",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Text(
              "Total Points: $points",
              style: TextStyle(fontSize: 17),
            ),
            Padding(padding: EdgeInsets.all(15)),
            Center(
                child: Text(
              "Statistics Shots",
              style: TextStyle(fontSize: 20),
            )),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "No shotings: ${values[0]}",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Center(
                child: Text(
              "0 Point: ${values[1]}",
              style: TextStyle(fontSize: 15),
            )),
            Row(
              children: [
                Spacer(),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                    child: Text(
                      "1 Point: ${values[2]}",
                      style: TextStyle(fontSize: 15),
                    )),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Text(
                    "2 Point: ${values[3]}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.black,
                  ),
                  child: Text(
                    "3 Point: ${values[4]}",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.black,
                  ),
                  child: Text(
                    "4 Point: ${values[5]}",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyan, width: 2),
                    color: Colors.cyan,
                  ),
                  child: Text(
                    "5 Point: ${values[6]}",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyan, width: 2),
                    color: Colors.cyan,
                  ),
                  child: Text(
                    "6 Point: ${values[7]}",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent, width: 2),
                    color: Colors.redAccent,
                  ),
                  child: Text(
                    "7 Point: ${values[8]}",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent, width: 2),
                    color: Colors.redAccent,
                  ),
                  child: Text(
                    "8 Point: ${values[9]}",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 2),
                    color: Colors.yellow,
                  ),
                  child: Text(
                    "9 Point: ${values[10]}",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 2),
                    color: Colors.yellow,
                  ),
                  child: Text(
                    "10 Point: ${values[11]}",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.yellow,
                  ),
                  child: Text(
                    "X Point: ${values[12]}",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Number Arrow Shots: $numberShotsArrow",
                  style: TextStyle(fontSize: 17),
                ),
                Spacer(),
                Text(
                  "Number Rounds: $numberRounds",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            Text(
              "Total Points: $points",
              style: TextStyle(fontSize: 17),
            ),
            Padding(padding: EdgeInsets.all(15)),
            Center(
                child: Text(
              "Statistics Shots",
              style: TextStyle(fontSize: 20),
            )),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle_outlined, size: 30,),
                        Text(
                          "No shotings: ${values[0]}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel_outlined, size: 30,),
                      Text(
                        "Point: ${values[1]}",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.do_disturb_on_outlined, size: 30,),
                      Text(
                        "Point: ${values[2]}",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline, size: 30,),
                      Text(
                        "Point: ${values[3]}",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, size: 30,),
                      Text(
                        "Point: ${values[4]}",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
