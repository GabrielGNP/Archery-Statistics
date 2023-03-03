import 'package:flutter/material.dart';

import '../models/TrainingSesion.dart';
import '../models/dataShotsRounds.dart';

class ButtonArrowPointsEmpty extends StatefulWidget{
  String iconButton = "-";
  int value = -1;
  DataShotsRounds dataShotsRound;
  TrainingSesion trainingSesion;

  ButtonArrowPointsEmpty({required this.dataShotsRound, required this.trainingSesion});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ButtonArrowPointsEmptyState(keyBAP: dataShotsRound.key);
  }

}



class ButtonArrowPointsEmptyState extends State<ButtonArrowPointsEmpty>{

  GlobalKey keyBAP = GlobalKey();
  bool disabled = false;
  String textbutton = "-";
  int value = -1;
  Color colorText = Color(0xFF80DA42);

  ButtonArrowPointsEmptyState({required this.keyBAP});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      key: keyBAP,
      padding: EdgeInsets.all(5.0),
      child: Container(
        width: 40.0,
        padding: EdgeInsets.zero,
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0),
            side: BorderSide(
                color: colorText, width: 2.0, style: BorderStyle.solid
            ),
          ),
          child: Text(
            "${widget.iconButton}",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 20.0,
                color: colorText
            ),
          ),
          onLongPress: (){
            Color colorSuport;
            if(disabled){
              disabled = false;
              colorSuport = Color(0xff5cda16);
              dataShotsRounds.forEach((dataRound) {
                dataRound.forEach((dataShot) {
                  if(dataShot.key == widget.dataShotsRound.key){
                    dataShot.disabled = false;
                  }
                });
              });

            }else{
              disabled = true;
              colorSuport = Color(0xff869d71);
              dataShotsRounds.forEach((dataRound) {
                dataRound.forEach((dataShot) {
                  if(dataShot.key == widget.dataShotsRound.key){
                    dataShot.disabled = true;
                  }
                });
              });
            }
            setState(() {
              colorText = colorSuport;
            });
          },
          onPressed: () {
            if(!disabled){
              value = value +1;
              String iconButtonSut="-";
              if(value>11){
                value = -1;
              }
              switch (value)
              {
                case -1:
                  iconButtonSut = "-";
                  break;
                case 0:
                  iconButtonSut = "0";
                  break;
                case 1:
                  iconButtonSut = "1";
                  break;
                case 2:
                  iconButtonSut = "2";
                  break;
                case 3:
                  iconButtonSut = "3";
                  break;
                case 4:
                  iconButtonSut = "4";
                  break;
                case 5:
                  iconButtonSut = "5";
                  break;
                case 6:
                  iconButtonSut = "6";
                  break;
                case 7:
                  iconButtonSut = "7";
                  break;
                case 8:
                  iconButtonSut = "8";
                  break;
                case 9:
                  iconButtonSut = "9";
                  break;
                case 10:
                  iconButtonSut = "10";
                  break;
                case 11:
                  iconButtonSut = "X";
                  break;
              }
              //print("empieza");

              dataShotsRounds.forEach((dataRound) {
                dataRound.forEach((dataShot) {
                  if(dataShot.key == keyBAP){
                    dataShot.value = value;
                    //print("está");
                  }
                  print("dataShot.key: ${dataShot.key} | keyBAP: $keyBAP");
                });
              });
              List<List<int>> ints = [];
              dataShotsRounds.forEach((element) {
                List<int> ints2 = [];
                element.forEach((element) {
                  ints2.add(element.value);
                });
                ints.add(ints2);
              });
              widget.trainingSesion.round = ints;
              print("ints: ${ints}");
              print("sesion: ${widget.trainingSesion.round}");
              setState(() {
                widget.iconButton = iconButtonSut;
              });
            }
          },

        ),
      ),
    );
  }

}