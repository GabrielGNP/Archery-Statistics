import 'package:flutter/material.dart';
import 'package:archery_statistics/models/dataShotsRounds.dart';

import '../MetaData.dart';
import '../models/TrainingSesion.dart';
import '../models/widgetRound.dart';

class ButtonArrowHits extends StatefulWidget{
  WidgetRound widgetRound;
  DataShotsRounds dataShotsRound;

  ButtonArrowHits({required this.dataShotsRound, required this.widgetRound});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ButtonArrowHitsState(keyBAP: dataShotsRound.key,value: dataShotsRound.value, disabled: dataShotsRound.disabled);
  }

}

class ButtonArrowHitsState extends State<ButtonArrowHits>{

  GlobalKey keyBAP = GlobalKey();
  bool disabled = true;
  IconData iconButton = Icons.circle_outlined;
  /*Icons.circle_outlined;
  Icons.cancel_outlined;
  Icons.do_disturb_on_outlined;
  Icons.add_circle_outline;
  Icons.check_circle_outline;
  Icons.filter_tilt_shift;
              Icons.album_outlined;
              Icons.adjust;
              Icons.change_circle_outlined;
              Icons.dnd_forwardslash;
              Icons.keyboard_double_arrow_down;
              Icons.keyboard_arrow_down_rounded;
              Icons.keyboard_arrow_up_outlined;
              Icons.keyboard_double_arrow_up_outlined;
              Icons.done;
              Icons.done_all;
              Icons.gps_not_fixed;
              Icons.gps_fixed_rounded;
              Icons.gps_off;*/
  int value = -1;
  Color colorText = Color(0xff869d71);

  ButtonArrowHitsState ({required this.keyBAP, required this.disabled, required this.value});

  @override
  initState(){
    bool disabled = widget.dataShotsRound.disabled;
    IconData iconButtonSut = Icons.circle_outlined;
    switch (value){
      case -1:
        iconButtonSut = Icons.circle_outlined;
        break;
      case 0:
        iconButtonSut = Icons.cancel_outlined;
        break;
      case 1:
        iconButtonSut = Icons.do_disturb_on_outlined;
        break;
      case 2:
        iconButtonSut = Icons.add_circle_outline;
        break;
      case 3:
        iconButtonSut = Icons.check_circle_outline;
        break;
    }
    Color colorSuport;
    if(disabled){
      colorSuport = Color(0xff869d71);
    }else{
      colorSuport = Color(0xff5cda16);
    }

    setState(() {
      iconButton = iconButtonSut;
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
          child: Icon(
            iconButton,
            size: 35.0,
            color: colorText,
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
              IconData iconButtonSut= Icons.circle_outlined;
              if(value>3){
                value = -1;
              }
              switch (value)
              {
                case -1:
                  iconButtonSut = Icons.circle_outlined;
                  break;
                case 0:
                  iconButtonSut = Icons.cancel_outlined;
                  break;
                case 1:
                  iconButtonSut = Icons.do_disturb_on_outlined;
                  break;
                case 2:
                  iconButtonSut = Icons.add_circle_outline;
                  break;
                case 3:
                  iconButtonSut = Icons.check_circle_outline;
                  break;
              }
              widget.dataShotsRound.value = value;
              widget.widgetRound.valuesInRound[widget.widgetRound.dataRound.indexOf(widget.dataShotsRound)] = value;

              print("value: ${value}");
              print("widget.dataShotsRound.value: ${widget.dataShotsRound.value}");
              print("widget.widgetRound.valuesInRound: ${widget.widgetRound.valuesInRound}");
              reLoadStateDST(true);
              setState(() {
                iconButton = iconButtonSut;
              });
            }
          },

        ),
      ),
    );
  }

}