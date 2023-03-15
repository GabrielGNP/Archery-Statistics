import 'package:archery_statistics/DataSaves/LinkedFiles.dart';
import 'package:archery_statistics/models/TrainingSesion.dart';
import 'package:archery_statistics/widgets/dataSesionTraining.dart';
import 'package:archery_statistics/widgets/scrollableWidget.dart';
import 'package:flutter/material.dart';

import '../MetaData.dart';
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

  reloadData() async {
    List<Widget> listRoundsAux = [];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        });
    reLoadStateDST(true);
      setState(() {
        listRounds = [];
      });


    new Future.delayed(const Duration(milliseconds: 200), () {
      reGenerate();
    });

  }

  reGenerate(){

    List<Widget> listRoundsAux = [];
    int count = 0;
    rounds.forEach((round){
      count++;
      print(round.row);
      listRoundsAux.add(
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            margin: EdgeInsets.all(10.0),
            //color: Color.fromARGB(255, 232, 232, 232),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("ronda " + (count).toString()),
                  ),
                  round.row
                ],
              ),
            ),
          ));
    });
    //para agregar los floatingActionButtons
    listRoundsAux.add(
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                    left: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                    right: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                    bottom: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(105, 116, 168, 91),
                        spreadRadius: 2,
                        blurRadius: 10
                    )
                  ]
              ),
              child: FloatingActionButton(
                  heroTag: "0",
                  foregroundColor: Color.fromARGB(255, 74, 199, 12),
                  elevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  splashColor: Color.fromARGB(116, 74, 199, 12),
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.add,
                    size: 35,
                  ),
                  onPressed: () {
                    newRound(sesionTraining);
                  }
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                    left: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                    right: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                    bottom: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(105, 116, 168, 91),
                        spreadRadius: 2,
                        blurRadius: 10
                    )
                  ]
              ),
              child: FloatingActionButton(
                  heroTag: "1",
                  foregroundColor: Color.fromARGB(255, 74, 199, 12),
                  elevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  splashColor: Color.fromARGB(116, 74, 199, 12),
                  backgroundColor: Colors.transparent,
                  child: Icon(
                      Icons.save_as
                  ),
                  onPressed: () {
                    saveDataValues();
                  }
              ),
            ),
          ],
        ),
      ),
    );

    setState(() {
      listRounds = listRoundsAux;
    });
    Navigator.pop(context);
  }

  loadDataInit(TrainingSesion trainingSesion) {
    rounds = [];
    setState(() {
      listRounds = [];
    });

    trainingSesion.round.forEach((valuesInRound) {
      rounds.add(WidgetRound(valuesInRound: valuesInRound, row: Row()));
    });

    List<Widget> listRoundsAux = [];
    generateRoundsTable(rounds);
    print("rounds.length: ${rounds.length}");
    int count = 0;
    rounds.forEach((round){
      count++;
      print(round.row);
      listRoundsAux.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          margin: EdgeInsets.all(10.0),
          //color: Color.fromARGB(255, 232, 232, 232),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("ronda " + (count).toString()),
                ),
                round.row
              ],
            ),
          ),
        )
      );
    });
    //para agregar los floatingActionButtons
    listRoundsAux.add(
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                          left: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                          right: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                          bottom: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(105, 116, 168, 91),
                              spreadRadius: 2,
                              blurRadius: 10
                          )
                        ]
                    ),
                    child: FloatingActionButton(
                        heroTag: "0",
                        foregroundColor: Color.fromARGB(255, 74, 199, 12),
                        elevation: 0,
                        focusElevation: 0,
                        highlightElevation: 0,
                        splashColor: Color.fromARGB(116, 74, 199, 12),
                        backgroundColor: Colors.transparent,
                        child: Icon(
                            Icons.add,
                          size: 35,
                        ),
                        onPressed: () {
                          newRound(sesionTraining);
                        }
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                        left: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                        right: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                        bottom: BorderSide(width: 2.0, color: Color.fromARGB(255, 74, 199, 12)),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(105, 116, 168, 91),
                          spreadRadius: 2,
                            blurRadius: 10
                        )
                      ]
                    ),
                    child: FloatingActionButton(
                        heroTag: "1",
                        foregroundColor: Color.fromARGB(255, 74, 199, 12),
                        elevation: 0,
                        focusElevation: 0,
                        highlightElevation: 0,
                        splashColor: Color.fromARGB(116, 74, 199, 12),
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.save_as
                        ),
                        onPressed: () {
                          saveDataValues();
                        }
                    ),
                  ),
                ],
              ),
            ),
        );

    setState(() {
      listRounds = listRoundsAux;
    });
  }

  exit(){
    saveDataValues();
    Navigator.pop(context);
  }
  saveDataValues() async {
    try{
      await saveData("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves", sesionTraining);
      reloadData();
      _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green,),
          Text(" guardado"),
        ],
      )));
    }catch(e){
      print(" error en el guardado");
      _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Row(
        children: [
          Icon(Icons.error, color: Colors.red,),
          Text("ERROR al guardado"),
        ],
      )));
    }
  }

  double widthTotal = 0.0;
  @override
  void initState() {

    loadDataInit(sesionTraining);
    super.initState();
  }

  String iconButton = "-";
  int value = -1;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              exit();
              //saveDataValues();
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height- (MediaQuery.of(context).size.height/5)),
                color: Color.fromARGB(255, 236, 236, 236),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: listRounds,
                  ),
                ),
              ),
              DataSesionTraining(widgetRounds: rounds, typeSesion: sesionTraining.type,),
            ],
          ),
        ),
      ),
    );
  }

  newRound(TrainingSesion trainingSesion) {
    List<int> values = [];
    for(int i=0; i<sesionTraining.shots; i++){
      values.add(-1);
    }
    sesionTraining.round.add(values);

    List<Widget> buttons = [];

    WidgetRound newWidgetRound = WidgetRound(valuesInRound: values, row: Row());

    newWidgetRound.dataRound.forEach((dataShot) {
      if(sesionTraining.type == "Points"){
        buttons.add(ButtonArrowPoints(widgetRound: newWidgetRound, dataShotsRound: dataShot,));
      } else {
        buttons.add(ButtonArrowHits(widgetRound: newWidgetRound, dataShotsRound: dataShot,));
      }
    });
    reLoadStateDST(true);
    // agrega el botón para eliminar el row
    buttons.add(IconButton(
      icon: Icon(Icons.delete_forever), onPressed: () {
      //deleteRound("IdentiKey$posData");
      List<bool> abailable =[];
      newWidgetRound.dataRound.forEach((dataShot) {
        abailable.add(dataShot.disabled);
      });
      if(abailable.contains(true)){
        print("___________________no te puedo deleteo________________");
        print("${newWidgetRound.valuesInRound}");
        print("${abailable}");
      }else{
        print("___________________si te puedo deleteo________________");
        print("${newWidgetRound.valuesInRound}");
        print("${abailable}");

        int pos = rounds.indexOf(newWidgetRound);
        print(newWidgetRound.valuesInRound);
        print(pos);
        rounds.remove(newWidgetRound);
        print(sesionTraining.round);

        sesionTraining.round.removeAt(pos);
        print(sesionTraining.round);
        reLoadStateDST(true);
        reloadData();
      }
    },
    ));
    // _______________________________________

    Widget row = Row(
      children: buttons,
    );
    newWidgetRound.row = row;

    rounds.add(newWidgetRound);
    reloadData();
  }


  generateRoundsTable(List<WidgetRound> rounds) {
    int count = 0;
    rounds.forEach((round) {
      count++;
      List<Widget> row = [];
      round.dataRound.forEach((dataShot) {
        if(sesionTraining.type == "Points"){
          row.add(ButtonArrowPoints(widgetRound: round, dataShotsRound: dataShot,));
        } else {
          row.add(ButtonArrowHits(widgetRound: round, dataShotsRound: dataShot,));
        }

      });

      // agrega el botón para eliminar el row
      row.add(IconButton(
        icon: Icon(Icons.delete_forever), onPressed: () {
        //deleteRound("IdentiKey$posData");
        List<bool> abailable =[];
        round.dataRound.forEach((dataShot) {
          abailable.add(dataShot.disabled);
        });
        if(abailable.contains(true)){
          print("___________________no te puedo deleteo________________");
          print("${round.valuesInRound}");
          print("${abailable}");
        }else{
          print("___________________si te puedo deleteo________________");
          print("${round.valuesInRound}");
          print("${abailable}");

          int pos = rounds.indexOf(round);
          print(round.valuesInRound);
          print(pos);
          rounds.remove(round);
          print(sesionTraining.round);

          sesionTraining.round.removeAt(pos);
          print(sesionTraining.round);
          reloadData();

        }
      },
      ));
      // _______________________________________

      round.row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        key: ValueKey("key${count}"),
        children: row,
      );
    });



    //______________________________________________

  }


}