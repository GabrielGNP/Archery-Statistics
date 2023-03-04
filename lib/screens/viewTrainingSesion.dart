import 'package:archery_statistics/DataSaves/LinkedFiles.dart';
import 'package:archery_statistics/models/TrainingSesion.dart';
import 'package:archery_statistics/widgets/scrollableWidget.dart';
import 'package:flutter/material.dart';

import '../models/dataShotsRounds.dart';
import '../models/widgetRound.dart';
import '../widgets/buttonArrowHits.dart';
import '../widgets/buttonArrowHitsEmpty.dart';
import '../widgets/buttonArrowPoints.dart';
import '../widgets/buttonArrowPointsEmpty.dart';




class ViewTrainingSesion extends StatefulWidget{

  ViewTrainingSesion({Key? key, required this.sesionTraining}) : super(key: key);
  late TrainingSesion sesionTraining;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ViewTrainingSesion(sesionTraining: sesionTraining);
  }

}

List<Widget> listRounds = [];
List<String> roundIdentificationKeyStack = [];

class _ViewTrainingSesion extends State<ViewTrainingSesion> {

  TrainingSesion sesionTraining;
  late List<WidgetRound> rounds = [];

  _ViewTrainingSesion({ required this.sesionTraining});


  loadDataInit(TrainingSesion trainingSesion) async {
    trainingSesion.round.forEach((valuesInRound) {
      rounds.add(WidgetRound(valuesInRound: valuesInRound, row: Row()));
    });

    List<Widget> listRoundssup = [];
    generateRoundsTable(rounds);
    rounds.forEach((round){
      listRoundssup.add(round.row);
    });
    //para agregar los floatingActionButtons
    listRoundssup.add(
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                  child: Row(
                    children: [
                      FloatingActionButton(
                          backgroundColor: Color.fromARGB(255, 74, 199, 12),
                          child: Text(
                            "+",
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Color.fromARGB(255, 43, 117, 5)
                            ),
                          ),
                          onPressed: () {
                            newRound(sesionTraining);
                          }
                      ),
                      FloatingActionButton(
                          heroTag: "1",
                          backgroundColor: Color.fromARGB(255, 74, 199, 12),
                          child: Text(
                            "L",
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Color.fromARGB(255, 43, 117, 5)
                            ),
                          ),
                          onPressed: () {
                            print(
                                "dataShotsRounds.length ${dataShotsRounds.length}");
                            print(
                                "trainingSesion.round.length ${trainingSesion.round
                                    .length}");
                            print("===============");
                            dataShotsRounds.forEach((dataRounds) {
                              print(dataRounds[0].key.toString() + " " +
                                  dataRounds[1].key.toString() + " " +
                                  dataRounds[2].key.toString());
                              // print(dataRounds[0].value.toString() +" "+ dataRounds[1].value.toString() +" "+ dataRounds[2].value.toString());
                            }); /*
                      print("_______________");
                        trainingSesion.round.forEach((listValue) {
                          print(listValue[0].toString() +" "+ listValue[1].toString() +" "+ listValue[2].toString());
                        });*/
                            /*dataShotsRounds.forEach((element) {
                          element.forEach((dataShot) {
                            print(dataShot.key);
                          });
                        });*/
                          }
                      ),
                    ],
                  ),
                ),
              ],
            )
        );

    setState(() {
      listRounds = listRoundssup;
    });
  }

  saveDataValues() async {

    Navigator.pop(context);
  }

  @override
  void initState() {
    loadDataInit(sesionTraining);
    super.initState();
  }

  String iconButton = "-";
  int value = -1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              saveDataValues();
              //Navigator.pop(context);

            }),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text("date: ${sesionTraining.getDateYMD()}"),
              Container(
                width: 58.0,
              ),
              Text("arrows: ${sesionTraining.shots}")
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.bottomLeft,
                  radius: 5.0,
                  colors: [
                    Colors.white,
                    Color.fromARGB(255, 113, 253, 55),
                    Color.fromARGB(255, 74, 199, 12)
                  ])
          ),
        ),
      ),
      body: ScrollableWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listRounds,
        ),
      ),
    );
  }

  newRound(TrainingSesion trainingSesion) {
    print("agregar nueva ronda");
  }


  generateRoundsTable(List<WidgetRound> rounds) {


    for(int i=0; i<rounds.length;i++){

      List<Widget> row = [];

      row.add(
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("ronda " + i.toString()
          ),
        ),
      );

      rounds[i].dataRound.forEach((dataShot) {
        if(sesionTraining.type == "Points"){
          row.add(ButtonArrowPoints(widgetRound: rounds[i], dataShotsRound: dataShot,));
        } else {
          row.add(ButtonArrowHits(widgetRound: rounds[i], dataShotsRound: dataShot,));
        }
      });

      //int posData = sesionTraining.round.indexOf(sesion);
      //roundIdentificationKeyStack.add("IdentiKey$posData");
      // agrega el botón para eliminar el row
      row.add(IconButton(
        icon: Icon(Icons.delete_forever), onPressed: () {
        //deleteRound("IdentiKey$posData");

        List<bool> abailable =[];
        rounds[i].dataRound.forEach((dataShot) {
          abailable.add(dataShot.disabled);
        });
        if(abailable.contains(true)){
          print("___________________no te puedo deleteo________________");
          print("${rounds[i].valuesInRound}");
          print("${abailable}");
        }else{
          print("___________________si te puedo deleteo________________");
          print("${rounds[i].valuesInRound}");
          print("${abailable}");
        }

      },
      ));
      // _______________________________________

      rounds[i].row = Row(
        children: row,
      );
    };


    //______________________________________________

  }


}