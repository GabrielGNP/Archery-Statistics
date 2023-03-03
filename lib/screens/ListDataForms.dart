import 'package:archery_statistics/widgets/scrollableWidget.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/TrainingSesion.dart';
import '../widgets/buildDataTable.dart';




GlobalKey listKey = new GlobalKey();

class ListDataForms extends StatefulWidget{

  final List<TrainingSesion> trainingSesionslist;

  const ListDataForms({Key? key, required this.trainingSesionslist}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListDataForms(trainingSesionsList: trainingSesionslist);
  }
}


class _ListDataForms extends State<ListDataForms>{

  final List<TrainingSesion> trainingSesionsList;

  _ListDataForms({required this.trainingSesionsList});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:
      Column(
        key: listKey,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //widgetsFloatingButtonsFiles(),
          BuildDataTable(
            key: keyBuildDataTableSt,
            trainingSesionslist: trainingSesionsList,
          ),
          /*Container(
            width: 100,
            height: 100,
            color: Colors.red,
          )*/

          /* Table(
            border: TableBorder.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 2),
            children: [
              TableRow( children: [
                Column(children:[Text('Day', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('Type', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('Shots', style: TextStyle(fontSize: 20.0))]),
                Column(children:[Text('Score', style: TextStyle(fontSize: 20.0))]),
              ]),
              TableRow( children: [
                Column(children:[Text('07/02/2023')]),
                Column(children:[Text('Points')]),
                Column(children:[Text('3')]),
                Column(children:[Text('29')]),
              ]),
              TableRow( children: [
                Column(children:[Text('08/02/2023')]),
                Column(children:[Text('Hits')]),
                Column(children:[Text('3')]),
                Column(children:[Text('3')]),
              ]),
              TableRow( children: [
                Column(children:[Text('09/02/2023')]),
                Column(children:[Text('Points')]),
                Column(children:[Text('3')]),
                Column(children:[Text('28')]),
              ]),
            ],
          ),*/

        ],
      ),
    );
  }

}