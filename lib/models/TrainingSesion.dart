import 'dart:core';

class TrainingSesion{
  late String name;
  late DateTime date;
  late String type;
  late int shots;
  late int score;
  late int rounds;
  late List<List<int>> round;

  TrainingSesion(
      this.date, this.type, this.shots, this.round){
    String nameFile;
    nameFile = dateToString();

    nameFile = nameFile.replaceAll(" ", "_");
    nameFile = nameFile.replaceAll(":", "");
    nameFile = nameFile.replaceAll(".", "");
    this.name = nameFile;
    this.rounds = this.round.length;

    int scoreAux =0;
    if(this.round.length > 0){
      if(this.type=="Points"){
        this.round.forEach((rounda) {
          rounda.forEach((shot) {
            if(shot <= 0){
              scoreAux = scoreAux + 0;
            }else if(shot >10){
              scoreAux = scoreAux + 10;
            }else{
              scoreAux = scoreAux + shot;
            }
          });
        });
      }else{
        scoreAux = (-1);
      }
    }else{
      scoreAux = 0;
    }

    this.score = scoreAux;
  }

  String dateToString(){
    DateTime date = this.date;
    String dateString = date.year.toString();

    if(date.month <10){
      dateString = dateString + "-0" + date.month.toString();

    }else{
      dateString = dateString + "-" + date.month.toString();

    }
    if(date.day <10){
      dateString = dateString + "-0" + date.day.toString();

    }else{
      dateString = dateString + "-" + date.day.toString();

    }
    if(date.hour <10){
      dateString = dateString + " 0"+date.hour.toString();

    }else{
      dateString = dateString + " "+date.hour.toString();

    }
    if(date.minute <10){
      dateString = dateString + ":0"+date.minute.toString();

    }else{
      dateString = dateString + ":"+date.minute.toString();
    }
    if(date.second <10){
      dateString = dateString + ":0"+date.second.toString();

    }else{
      dateString = dateString + ":"+date.second.toString();
    }
    if(date.millisecond <10){
      dateString = dateString + ".00"+date.millisecond.toString();

    }else if(date.millisecond < 100){
      dateString = dateString + ".0"+date.millisecond.toString();

    }else{
      dateString = dateString + "."+date.millisecond.toString();
    }
    return dateString;
  }

  String getDateYMD(){
    String dateYMD = "";
    if(this.date.day <10){
      dateYMD = "0"+this.date.day.toString();
    }else{
      dateYMD = this.date.day.toString();
    }
    if(this.date.month <10){
      dateYMD = dateYMD + "/0"+this.date.month.toString();
    }else{
      dateYMD = dateYMD + "/"+this.date.month.toString();
    }
    dateYMD = dateYMD + "/"+this.date.year.toString();
    return dateYMD;
  }

  String getRoundsInString(){
    String roundsString="{";
    this.round.forEach((round) {
      roundsString=roundsString+"[";
      round.forEach((shot) {
        roundsString=roundsString+"$shot,";
      });
      roundsString = roundsString.substring(0,roundsString.length-1);
      roundsString=roundsString+"]";
    });
    roundsString=roundsString+"}";

    return roundsString;
  }
}

List<TrainingSesion> sesions = [
  TrainingSesion(DateTime.now(), "Points", 3, [[10,10,10],[10,10,10]]),
  TrainingSesion(DateTime.now(), "Hits", 3, [[3,2,2],[2,3,2,],[2,1,0]]),
  TrainingSesion(DateTime.utc(2023, 02, 09, 17,00,00,001), "Points", 3, [[10,10,10]]),
  TrainingSesion(DateTime.utc(2023, 02, 10, 17,01,01,000), "Points", 3, [[10,10,10],[10,10,10]]),
  TrainingSesion(DateTime.utc(2023, 02, 11, 17,02,02,000), "Hits", 3, [[3,2,2]]),
  TrainingSesion(DateTime.utc(2023, 02, 12, 17,03,03,000), "Hits", 3, [[3,1,3],[2,3,2]]),
];

List<TrainingSesion> trainingSesions = [];