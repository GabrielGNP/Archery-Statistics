import 'package:flutter/material.dart';
import 'package:archery_statistics/models/dataShotsRounds.dart';
import 'package:archery_statistics/models/widgetRound.dart';

import '../MetaData.dart';


class ButtonArrowPoints extends StatefulWidget{
  WidgetRound widgetRound;
  DataShotsRounds dataShotsRound;

  ButtonArrowPoints({required this.dataShotsRound, required this.widgetRound});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ButtonArrowPointsState(keyBAP: dataShotsRound.key,value: dataShotsRound.value, disabled: dataShotsRound.disabled);
  }

}

class ButtonArrowPointsState extends State<ButtonArrowPoints>{

  GlobalKey keyBAP;
  bool disabled = true;
  String textbutton = "-";
  int value = -1;
  Color colorText = Color(0xff869d71);

  ButtonArrowPointsState ({required this.keyBAP, required this.value, required this.disabled});

  @override
  void initState() {
    bool disabled = widget.dataShotsRound.disabled;
    String textbuttonSup = "-";
    switch (value)
    {
      case -1:
        textbuttonSup = "-";
        break;
      case 0:
        textbuttonSup = "0";
        break;
      case 1:
        textbuttonSup = "1";
        break;
      case 2:
        textbuttonSup = "2";
        break;
      case 3:
        textbuttonSup = "3";
        break;
      case 4:
        textbuttonSup = "4";
        break;
      case 5:
        textbuttonSup = "5";
        break;
      case 6:
        textbuttonSup = "6";
        break;
      case 7:
        textbuttonSup = "7";
        break;
      case 8:
        textbuttonSup = "8";
        break;
      case 9:
        textbuttonSup = "9";
        break;
      case 10:
        textbuttonSup = "10";
        break;
      case 11:
        textbuttonSup = "X";
        break;
    }
    Color colorSuport;
    if(disabled){
      colorSuport = Color(0xff869d71);
    }else{
      colorSuport = Color(0xff5cda16);
    }
    setState(() {
      textbutton = textbuttonSup;
      colorText = colorSuport;
    });
    super.initState();
  }

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
            "${textbutton}",
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
              widget.dataShotsRound.disabled = false;

            }else{
              disabled = true;
              colorSuport = Color(0xff869d71);
              widget.dataShotsRound.disabled = true;
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
              widget.dataShotsRound.value = value;
              widget.widgetRound.valuesInRound[widget.widgetRound.dataRound.indexOf(widget.dataShotsRound)] = value;

              print("value: ${value}");
              print("widget.dataShotsRound.value: ${widget.dataShotsRound.value}");
              print("widget.widgetRound.valuesInRound: ${widget.widgetRound.valuesInRound}");
              reLoadStateDST(true);
              setState(() {
                textbutton = iconButtonSut;
              });
            }
          },

        ),
      ),
    );
  }

}