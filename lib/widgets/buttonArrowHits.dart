import 'package:flutter/material.dart';
import 'package:archery_statistics/models/dataShotsRounds.dart';

import '../models/TrainingSesion.dart';

class ButtonArrowHits extends StatefulWidget{
  DataShotsRounds dataShotsRound;
  TrainingSesion trainingSesion;

  ButtonArrowHits({required this.dataShotsRound, required this.trainingSesion});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ButtonArrowHitsState(keyBAP: dataShotsRound.key,value: dataShotsRound.value, textbutton: dataShotsRound.value.toString());
  }

}

class ButtonArrowHitsState extends State<ButtonArrowHits>{

  GlobalKey keyBAP = GlobalKey();
  bool disabled = true;
  String textbutton = "-";
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

  @override
  initState(){
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

    setState(() {
      iconButton = iconButtonSut;
    });
  }

  ButtonArrowHitsState ({required this.keyBAP, required this.textbutton, required this.value});

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
                    print(dataRound.indexOf(dataShot));
                    print(dataShotsRounds.indexOf(dataRound));
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
              dataShotsRounds.forEach((dataRound) {
                dataRound.forEach((dataShot) {
                  if(dataShot.key == keyBAP){
                    dataShot.value = value;
                  }
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
                iconButton = iconButtonSut;
              });
            }
          },

        ),
      ),
    );
  }

}