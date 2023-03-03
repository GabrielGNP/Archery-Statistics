import 'package:archery_statistics/DataSaves/LinkedFiles.dart';
import 'package:archery_statistics/models/TrainingSesion.dart';
import 'package:archery_statistics/widgets/scrollableWidget.dart';
import 'package:flutter/material.dart';

import '../models/dataShotsRounds.dart';
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

  _ViewTrainingSesion({ required this.sesionTraining});

  loadData(TrainingSesion trainingSesion, bool Bl) async {
    //si Bl es true, genera nuevamente la tabla agregando una nueva ronda
    //si Bl es false, solamente actualiza la tabla
    roundIdentificationKeyStack = [];
    List<Widget> listRoundssup = [];
    setState(() {
      listRounds = [];
    });
    if (Bl) {
      listRoundssup = addRoundAndGenerateRoundsTable(trainingSesion);
    } else {
      listRoundssup = generateRoundsTable(trainingSesion, false);
    }
    setState(() {
      listRounds = listRoundssup;
    });
  }

  loadDataInit(TrainingSesion trainingSesion) async {
    dataShotsRounds = [];
    roundIdentificationKeyStack = [];
    List<Widget> listRoundssup = [];
    listRoundssup = generateRoundsTable(trainingSesion, true);
    setState(() {
      listRounds = listRoundssup;
    });
  }

  saveDataValues() async {
    List<TrainingSesion> sesions = [];

    sesions = await readFilesInTrainingSesions();

    List<List<int>> valuesRounds = [];
    dataShotsRounds.forEach((dataRound) {
      List<int> valueShots = [];
      dataRound.forEach((dataShot) {
        valueShots.add(dataShot.value);
      });
      valuesRounds.add(valueShots);
    });

    int posSesion = 0;
    sesions.forEach((sesion) {
      if (sesion.name == sesionTraining.name) {
        posSesion = sesions.indexOf(sesion);
      } else {}
    });
    sesions[posSesion].round = valuesRounds;
    await saveData(
        "/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves",
        sesions[posSesion]);

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
    loadData(trainingSesion, true);
  }

  List<Row> addRoundAndGenerateRoundsTable(TrainingSesion trainingSesion) {
    List<Row> rowRounds = [];
    int roundsCount = 0;

    trainingSesion.round.forEach((sesion) {
      List<Widget> row = [];
      roundsCount++;
      row.add(
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("ronda " + roundsCount.toString()
          ),
        ),
      );

      if (trainingSesion.type == "Points") {
        row.addAll(generateButtonArrowPoints(sesion, false, (roundsCount-1)*3));
      } else {
        row.addAll(generateButtonArrowHits(sesion, false, (roundsCount-1)*3));
      }

      int posData = sesionTraining.round.indexOf(sesion);
      roundIdentificationKeyStack.add("IdentiKey$posData");
      row.add(IconButton(
        icon: Icon(Icons.delete_forever), onPressed: () {
        deleteRound("IdentiKey$posData");
      },
      ));
      rowRounds.add(
          Row(
            children: row,
          )
      );
    });

    List<int> newRoundList = [];
    for (int i = 0; i < trainingSesion.shots; i++) {
      newRoundList.add(-1);
    }
    trainingSesion.round.add(newRoundList);
    roundsCount++;
    List<Widget> newRow = [];
    newRow.add(Padding(
      padding: EdgeInsets.all(10.0),
      child: Text("ronda " + roundsCount.toString()
      ),
    ),);
    if (trainingSesion.type == "Points") {
      newRow.addAll(generateButtonArrowPoints(newRoundList, true));
    } else {
      newRow.addAll(generateButtonArrowHits(newRoundList, true));
    }

    //IconButton para borrar un row
    int posData = sesionTraining.round.indexOf(newRoundList);
    roundIdentificationKeyStack.add("IdentiKey$posData");
    newRow.add(IconButton(
      icon: Icon(Icons.delete_forever), onPressed: () {
      deleteRound("IdentiKey$posData");
    },
    ));

    rowRounds.add(
        Row(
          children: newRow,
        )
    );

    //para agregar los floatingActionButtons
    rowRounds.add(
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
                          print(dataRounds[0].value.toString() + " " +
                              dataRounds[1].value.toString() + " " +
                              dataRounds[2].value.toString());
                        });
                      }
                  ),
                ],
              ),
            ),
          ],
        )
    );
    //______________________________________________

    return rowRounds;
  }

  List<Row> generateRoundsTable(TrainingSesion trainingSesion,
      bool firstGenerate) {
    List<Row> rowRounds = [];
    int roundsCount = 0;
    trainingSesion.round.forEach((sesion) {
      List<Widget> row = [];
      roundsCount++;
      row.add(
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("ronda " + roundsCount.toString()
          ),
        ),
      );

      if (firstGenerate) {
        if (trainingSesion.type == "Points") {
          row.addAll(generateButtonArrowPoints(sesion, true));
        } else {
          row.addAll(generateButtonArrowHits(sesion, true));
        }
      } else {
        if (trainingSesion.type == "Points") {
          row.addAll(generateButtonArrowPoints(sesion, false,(roundsCount-1)*3));
        } else {
          row.addAll(generateButtonArrowHits(sesion, false, (roundsCount-1)*3));
        }
      }
      int posData = sesionTraining.round.indexOf(sesion);
      roundIdentificationKeyStack.add("IdentiKey$posData");
      // agrega el botón para eliminar el row
      row.add(IconButton(
        icon: Icon(Icons.delete_forever), onPressed: () {
        deleteRound("IdentiKey$posData");
      },
      ));
      // _______________________________________

      rowRounds.add(
          Row(
            children: row,
          )
      );
    });

    //para agregar los floatingActionButtons
    rowRounds.add(
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
    //______________________________________________

    return rowRounds;
  }

  List<Widget> generateButtonArrowPoints(List<int> shots, bool newButton, [int? round]) {
    List<Widget> buttons = [];
    List<DataShotsRounds> dataShotsRoundAux = [];

    if (!newButton) {
      dataShotsRounds.forEach((dataRound) {
        print("${dataRound[0].key} ${dataRound[1].key} ${dataRound[2].key} ");
        dataRound.forEach((dataShot) {
          dataShotsRoundAux.add(dataShot);
        });
      });
    }
    int countDataShots = 0;
    if(round == null){
      countDataShots = 0;
    }else{
      countDataShots = round;
    }

    print(countDataShots);
    shots.forEach((shot) {
      DataShotsRounds dataSR;
      if (newButton) {
        if (shot < 0) {
          dataSR = DataShotsRounds(GlobalKey(), shot, false);
          buttons.add(ButtonArrowPointsEmpty(
            dataShotsRound: dataSR, trainingSesion: sesionTraining,));
        } else {
          dataSR = DataShotsRounds(GlobalKey(), shot, true);
          buttons.add(ButtonArrowPoints(
            dataShotsRound: dataSR, trainingSesion: sesionTraining,));
        }
        dataShotsRoundAux.add(dataSR);
      } else {
        if (shot < 0) {
          print("añade la key: ${dataShotsRoundAux[countDataShots].key}");
          if(dataShotsRoundAux[countDataShots].value < 0){
            dataShotsRoundAux[countDataShots].disabled = false;
          }else{
            dataShotsRoundAux[countDataShots].disabled = true;
          }
          buttons.add(ButtonArrowPointsEmpty(
            dataShotsRound: dataShotsRoundAux[countDataShots],
            trainingSesion: sesionTraining,));
        } else {
          print("añade la key: ${dataShotsRoundAux[countDataShots].key}");
          if(dataShotsRoundAux[countDataShots].value < 0){
            dataShotsRoundAux[countDataShots].disabled = false;
          }else{
            dataShotsRoundAux[countDataShots].disabled = true;
          }
          buttons.add(ButtonArrowPoints(
            dataShotsRound: dataShotsRoundAux[countDataShots],
            trainingSesion: sesionTraining,));
        }
        countDataShots++;
      }
    });
    if (newButton) {
      dataShotsRounds.add(dataShotsRoundAux);
    }

    return buttons;
  }

  List<Widget> generateButtonArrowHits(List<int> shots, bool newButton, [int? round]) {
    List<Widget> buttons = [];
    List<DataShotsRounds> dataShotsRoundAux = [];

    if (!newButton) {
      dataShotsRounds.forEach((dataRound) {
        print("${dataRound[0].key} ${dataRound[1].key} ${dataRound[2].key} ");
        dataRound.forEach((dataShot) {
          dataShotsRoundAux.add(dataShot);
        });
      });
    }
    int countDataShots = 0;
    if(round == null){
      countDataShots = 0;
    }else{
      countDataShots = round;
    }

    print(countDataShots);
    shots.forEach((shot) {
      DataShotsRounds dataSR;
      if(newButton){
        if (shot < 0) {
          dataSR = DataShotsRounds(GlobalKey(), shot, false);
          buttons.add(ButtonArrowHitsEmpty(dataShotsRound: dataSR, trainingSesion: sesionTraining));
        } else {
          dataSR = DataShotsRounds(GlobalKey(), shot, true);
          buttons.add(ButtonArrowHits(dataShotsRound: dataSR, trainingSesion: sesionTraining));
        }
        dataShotsRoundAux.add(dataSR);
      }else{
        if(shot <0){
          print("añade la key: ${dataShotsRoundAux[countDataShots].key}");
          if(dataShotsRoundAux[countDataShots].value <0){
            dataShotsRoundAux[countDataShots].disabled = false;
          }else{
            dataShotsRoundAux[countDataShots].disabled = true;
          }
          buttons.add(ButtonArrowHitsEmpty(dataShotsRound: dataShotsRoundAux[countDataShots], trainingSesion: sesionTraining));
        }else{
          print("añade la key: ${dataShotsRoundAux[countDataShots].key}");
          if(dataShotsRoundAux[countDataShots].value < 0){
            dataShotsRoundAux[countDataShots].disabled = false;
          }else{
            dataShotsRoundAux[countDataShots].disabled = true;
          }
          buttons.add(ButtonArrowHits(dataShotsRound: dataShotsRoundAux[countDataShots], trainingSesion: sesionTraining));
        }
        countDataShots++;
      }
    });
    if(newButton){
      dataShotsRounds.add(dataShotsRoundAux);
    }
    return buttons;
  }

  deleteRound(String IdentiKey){
    List<bool> availableDelete = [];
    int posData = roundIdentificationKeyStack.indexOf(IdentiKey);
    print(roundIdentificationKeyStack);
    print(posData);
    print("sesionTraining.round[posData]: ${sesionTraining.round[posData]}");
    print("posData: ${posData}");
    print("sesionTraining.round.length: ${sesionTraining.round.length}");
    print("dataShotsRounds.length: ${dataShotsRounds.length}");
    dataShotsRounds[posData].forEach((dataShot) {
      availableDelete.add(dataShot.disabled);
    });
    print(dataShotsRounds.contains(dataShotsRounds[posData]));
    print(availableDelete);
    if (!availableDelete.contains(true)) {
      setState(() {
        listRounds = [];
      });
      print("puede borrar");
      dataShotsRounds.forEach((dataRound) {
        print(dataRound[0].key.toString() +" "+ dataRound[1].key.toString() +" "+ dataRound[2].key.toString()+ " "+dataRound[0].value.toString() +" "+ dataRound[1].value.toString() +" "+ dataRound[2].value.toString());
      });
      sesionTraining.round.forEach((dataRound) {
        print(dataRound);
      });
      sesionTraining.round.removeAt(posData);
      //dataShotsRounds.remove(dataShotsRounds[posData]);
      roundIdentificationKeyStack.removeAt(roundIdentificationKeyStack.indexOf(IdentiKey));
      dataShotsRounds.forEach((dataRound) {
        print(dataRound[0].key.toString() +" "+ dataRound[1].key.toString() +" "+ dataRound[2].key.toString()+ " "+dataRound[0].value.toString() +" "+ dataRound[1].value.toString() +" "+ dataRound[2].value.toString());
      });
      sesionTraining.round.forEach((dataRound) {
        print(dataRound);
      });
      print(roundIdentificationKeyStack);
      loadData(sesionTraining, false);
    } else {
      print("no puede borrar");
    }
  }
}