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
        ],
      ),
    );
  }

}