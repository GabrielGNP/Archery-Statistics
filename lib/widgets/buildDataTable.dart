import 'dart:async';

import 'package:archery_statistics/models/TrainingSesion.dart';
import 'package:archery_statistics/screens/viewTrainingSesion.dart';
import 'package:flutter/material.dart';
import 'package:archery_statistics/widgets/scrollableWidget.dart';

import '../DataSaves/LinkedFiles.dart';
import '../main.dart';

TrainingSesion sesion = new TrainingSesion(DateTime.now(), "points", 3, [[10,10,10]]);

class BuildDataTable extends StatefulWidget {

  final List<TrainingSesion> trainingSesionslist;

  const BuildDataTable({Key? key, required this.trainingSesionslist}) : super(key: key);

    @override
  BuildDataTableState createState() => BuildDataTableState(trainingSesionsList2: trainingSesionslist);
}

Key dataTable = new Key("cositas");


class BuildDataTableState extends State<BuildDataTable>{

  List<TrainingSesion> trainingSesionsList2;

  BuildDataTableState({required this.trainingSesionsList2});


  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        key: dataTable,
        children: [
      ScrollableWidget(
        child: buildDataTable(),

        ),
      ]
    );
  }

  loadData() async{
    List<TrainingSesion> auxtrainingSesions = await readFilesInTrainingSesions();
    setState(() {
      trainingSesionsList2 = auxtrainingSesions;
    });
  }

  Widget buildDataTable(){
    //final columns = ['Day', 'Type', 'Shots', 'Score'];
    final columns = ['Type','Rounds', 'Shots', 'Score','Day', ''];
    contRows = 0;
    return DataTable(
      /*border: TableBorder(
        left: BorderSide(color: Color(0xFFCAFAA4), width: 30, style: BorderStyle.solid)
      ),*/
      checkboxHorizontalMargin: 0,

      showCheckboxColumn: false,
      columns: getColumns(columns),
      //rows: [],
      rows: getRows(trainingSesionsList2),
      columnSpacing: 0,

    );
  }



  List<DataColumn> getColumns(List<String> columns) => columns.map((String column) => DataColumn(
      label: Container(
        //color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 19),
        alignment: Alignment.center,
        child: Text(
            column,
        ),
      ),
    )).toList();

  int contRows = 0;
  int selectedRow = 0;

  List<DataRow> getRows(List<TrainingSesion> forms) => forms.map((TrainingSesion form){

    String date = form.getDateYMD();
    String scores = "";
    if(form.score<0){
      scores = "-";
    }else{
      scores = form.score.toString();
    }

    final cells = [form.type, form.rounds ,form.shots, scores, date];

    List<DataCell> dataCells = getCells(cells);
    dataCells.add(DataCell(
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent
        ),
        onPressed: () {
          int valor = contRows;
          print("preparando eliminar");
          print("contRows:" + valor.toString());
          TrainingSesion delTrainingSesion = TrainingSesion(DateTime.now(), "-1", (-1), [[]]);
          trainingSesionsList2.forEach((element) {
            print("allForms:" + element.name + " | delRowForm: " + form.name);
            if(element.name == form.name){
              print("iguales");
              delTrainingSesion = element;
            }else{
              print("distintos");
            }
            print("______________________");
          });

          trainingSesionsList2.remove(delTrainingSesion);
          deleteFile("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves/"+delTrainingSesion.name+".txt");
          print("deleteado");
          loadData();
          //allForms.forEach((element) {print(element.day + " " + element.type+ " " + element.shots+ " " + element.score);});

        },
        //child: Text('X' + contRows.toString()),
        //child: Text('X'),
        child: Icon(
          //Icons.dangerous,
          Icons.delete,
          color: Color.fromARGB(255, 215, 30, 30),
          size: 30.0,
        ),
      ),
    ));
    contRows++;
    //print(form.name);
    //return Dismissible(key: Key(contRows.toString()), child: child);
    return DataRow(
        /*onSelectChanged: (selected) {
            print("name:" + form.name);
            print("date:" + form.dateToString());
          },*/
        onLongPress: () {
          print('========================== ');
          print("name"+form.name);
          print("date: ${form.date}");
          print("shots: ${form.shots}");
          print("score: ${form.score}");
          print("rounds: ${form.rounds}");
          print(form.getRoundsInString());

          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return ViewTrainingSesion(
                sesionTraining: form,
              );
            },
          )).then((value) {
            keyBuildDataTableSt.currentState?.loadData();
          });
        },
        cells: dataCells
    );
  }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) => DataCell(
      Container(
        alignment: Alignment.center,
        child: Text(
            '$data',
        ),
      )
  )).toList();
}






