import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:archery_statistics/widgets/navigationBar.dart';

import '../DataSaves/LinkedFiles.dart';
import '../models/TrainingSesion.dart';

List<String> types = ['Points', 'Hits'];

String dateToString(DateTime date) {
  String day;
  String month;
  String year;
  if (date.day < 10) {
    day = 0.toString() + date.day.toString();
  } else {
    day = date.day.toString();
  }
  if (date.month < 10) {
    month = 0.toString() + date.month.toString();
  } else {
    month = date.month.toString();
  }
  return day + '/' + month + '/' + date.year.toString();
}

DateTime stringToDate(String dateString){

  int year, month, day;

  day = int.parse(dateString.substring(0,dateString.indexOf("/")));
  dateString = dateString.substring(dateString.indexOf("/")+1);
  month = int.parse(dateString.substring(0,dateString.indexOf("/")));
  dateString = dateString.substring(dateString.indexOf("/")+1);
  year = int.parse(dateString);

  DateTime dateTime = DateTime(year,month,day,DateTime.now().hour,DateTime.now().minute,DateTime.now().second,DateTime.now().millisecond);

  print(dateTime);
  return dateTime;
}

String optionDropDown = types.first;

class AddForm extends StatefulWidget {

  @override
  _AddForm createState() => _AddForm();
  /*
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddForm();
  }*/
}



class _AddForm extends State<AddForm> {

  DateTime date = DateTime.now();
  int numberArrows = 3;
  String countingMode = "Points";
  String infoMesage = "";

  GlobalKey formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)
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
            /*gradient: LinearGradient(
              colors: [Colors.white, Colors.lightGreenAccent], stops: [0.5, 1.0],
            ),*/
          ),
        ),
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(children: [
                        Container(
                          height: 75.0,
                          padding: EdgeInsets.all(10.0),
                          width: 170.0,
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Day',
                              labelStyle: TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 135, 135, 135)
                              ),
                            ),
                            initialValue: dateToString(date),
                            onChanged: (value){
                              print(value);
                              date = stringToDate(value);

                            },
                          ),
                        ),
                        Container(
                          height: 75.0,
                          padding: EdgeInsets.all(10.0),
                          width: 170.0,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: 3.toString(),
                            //para aceptar solamente valores numericos
                            //se debe importar la librería import 'package:flutter/services.dart';
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              // for version 2 and greater youcan also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'number of arrows per round',
                              labelStyle: TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 135, 135, 135)
                              ),
                            ),
                            onChanged: (value){
                              print(value);
                              if(int.parse(value)<1 || value == null || value==""){
                                numberArrows = -1;
                              }else{
                                numberArrows = int.parse(value);
                              }
                            },
                          ),
                        ),
                      ]),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child:  Text(
                                    "Points counting mode",
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Color.fromARGB(255, 135, 135, 135)
                                    ),
                                  ),
                                ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                width: 100,
                                child: DropdownButton(
                                  value: optionDropDown,
                                  items: types.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (String? value) {
                                    countingMode = value!;
                                    setState(() {
                                      optionDropDown = value;
                                    });
                                  }),)
                            ],
                          )
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 92, 201, 40),
                          shadowColor: Colors.transparent
                        ),
                        child: Text(
                          "crear registro",
                          style: TextStyle(
                            fontSize: 17.0
                          ),
                        ),
                        onPressed: () {
                          if(numberArrows>0){
                            setState(() {
                              optionDropDown = types.first;
                            });
                            List<int> round = [];
                            for(int i=0; i<numberArrows; i++){
                              round.add(-1);
                            }
                            TrainingSesion sesion = new TrainingSesion(date, countingMode, numberArrows, [round]);
                            createFile("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves", sesion);
                            Navigator.pop(context);
                          }else{
                            setState(() {
                              infoMesage = "el número de flechas no puede ser inferior a 1";
                            });
                          }
                        },
                      ),
                      Text(infoMesage),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
