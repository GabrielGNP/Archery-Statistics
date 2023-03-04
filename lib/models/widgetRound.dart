import 'package:flutter/cupertino.dart';

import 'dataShotsRounds.dart';

class WidgetRound{
  List<DataShotsRounds> dataRound = [];
  Widget row;
  List<int> valuesInRound;

  WidgetRound({required this.valuesInRound, required this.row}){
    valuesInRound.forEach((value) {
      if(value<0){
        dataRound.add(DataShotsRounds(GlobalKey(),value,false));
      }else{
        dataRound.add(DataShotsRounds(GlobalKey(),value,true));
      }
    });
  }

}