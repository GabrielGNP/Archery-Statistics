import 'dart:io';



import 'package:archery_statistics/widgets/scrollableWidget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/TrainingSesion.dart';

Future<String> getPath (){
  return _localPath;
}

Future<String> get _localPath async {

  final directory = await getApplicationDocumentsDirectory().then(
          (directory) async {

            List<String> paths = await _listPathsAndFilesInFolder(directory.path + '/infoSaves');
            String aplicationPath = directory.path;
            print("____________________________________");
            print("in= " + directory.path + '/infoSaves');
            print("lenght= " + paths.length.toString());
            paths.forEach((element) {print(element);});
  /*
            _createFile((directory.path+'/infoSaves'),"dataSave2");
            await _listPathsAndFilesInFolder(directory.path + '/infoSaves').then((value)
            {
                print("____________________________________");
                print("in= " + directory.path + '/infoSaves');
                print("lenght= " + value.length.toString());
                value.forEach((element) {print(element);});
            });
            _deleteFile(directory.path+'/infoSaves/data.txt');
            await _listPathsAndFilesInFolder(directory.path + '/infoSaves').then((value)
            {
            print("____________________________________");
            print("in= " + directory.path + '/infoSaves');
            print("lenght= " + value.length.toString());
            value.forEach((element) {print(element);});
            });
*/
/*
            print(directory.path);
            print("____________________________________");
            final folder = new Directory(directory.path + '/infoSaves').create().then(
                  (folder) async {
                    print(folder.path);
                    print("____________________________________");
                    await for (var entity in
                    folder.list(recursive: true, followLinks: false)) {
                      print(entity.path);
                    }
                    print("____________________________________");

                    File saves = new File(folder.path+'/data.txt');
                    print(saves.path);
                    print("____________________________________");
                    print(folder.path);

                    Directory(saves.path).create();
                    await for (var entity in
                    folder.list(recursive: true, followLinks: false)) {
                      print(entity.path);
                    }
                  }
          );*/
          }
  );



  //Directory folder = await getApplicationDocumentsDirectory();

  /*new Directory(directory.path + '/infoSaves').create()
  // The created directory is returned as a Future.
      .then((Directory directory) async {
    //print(directory.path);
    folder = directory;
    print(folder.path);
    await for (var entity in
    folder.list(recursive: true, followLinks: false)) {
      print(entity.path);
    }
  }
  );*/



  return "end";
}




//____________________________ Functionalities _____________________________________

//devuelve una lista de Strings con todos los folders y files en el path especificado
Future<List<String>> _listPathsAndFilesInFolder(String folder) async {
  List<String> paths = <String>[];
  await Directory(folder).create().then( (folder) async {
    await for (var entity in folder.list(recursive: true, followLinks: false)) {
      paths.add(entity.path);
    }
  }
  );
  return paths;
}

//Guarda la información en un archivo
Future<void> saveData(String pathfile, TrainingSesion sesion) async {
  String date = sesion.dateToString();
  String dataString = "date:"+date+"\n"+
      "shots:"+sesion.shots.toString()+"\n"+
      "type:"+sesion.type+"\n"+
      "rounds:"+sesion.rounds.toString()+"\n"+
      "round:{";

  sesion.round.forEach((round) {
    dataString = dataString+"[";
    for(int i=0; i < round.length; i++){
      dataString = dataString +round[i].toString();
      if(i+1 < round.length){
        dataString = dataString + ",";
      }
    }
    dataString = dataString + "]";
  });
  dataString = dataString+"}";
  print("pathfile: "+pathfile);
  print("file: "+pathfile+"/"+sesion.name+".txt");
  File file = await new File(pathfile+"/"+sesion.name+".txt");
  print("nameFile: "+ sesion.name);
  print(dataString);
  print("____________");
  file.writeAsString(dataString);
}

// crea un nuevo folder en el path especificado
Future<void> createFolder(String path, String name) async{
  Directory(path+"/"+name).create();
}

// crea un nuevo file en el path especificado
Future<void> createFile(String path, TrainingSesion sesion) async {
  if(!Directory(path).existsSync()){
    await createFolder("/data/user/0/com.GSmart.archery_statistics/app_flutter", "infoSaves");
  }

  if(sesion == null){
    print("sin datos");
  }else{
    if(!File(path+"/"+sesion.name+".txt").existsSync()){
      await File(path+"/"+sesion.name+".txt").create();
      await saveData(path, sesion);
    }
  }
}

// elimina el folder especificado
void deleteFolder(String path){
  Directory(path).delete();
}

//elimina el file especificado
void deleteFile(String pathFile){
  File(pathFile).delete();
}

loadDataFiles() async{
 List<TrainingSesion> trainingSesions = await readFilesInTrainingSesions();
}

// imprime en consola la información sobre todos los files dentro del path especificado
Future<List<TrainingSesion>> readFilesInTrainingSesions() async {
  List<File> files = <File>[];
  final directory = await getApplicationDocumentsDirectory();
  List<String> filesPaths = await _listPathsAndFilesInFolder(directory.path + '/infoSaves');
  filesPaths.forEach((filepath) {
    files.add(new File(filepath));
  });

  List<TrainingSesion> loadTrainingSesions = <TrainingSesion>[];
  print("files " + files.length.toString());

  for(var i=0; i<files.length;i++){
    String dataRead = await files[i].readAsString();
    String nameFile = files[i].path.replaceAll(directory.path.toString()+"/infoSaves/", "");
    nameFile = nameFile.replaceAll(".txt", "");
    String date;
    int shots;
    String type;
    int rounds;
    List<List<int>> round = <List<int>>[];

    date = (dataRead.replaceAll(dataRead.substring(dataRead.indexOf("\n")), "")).replaceAll("date:", "");
    dataRead = dataRead.substring(dataRead.indexOf("\n")).replaceAll("\n", "¡").substring(1);

    shots = int.parse(dataRead.replaceAll(dataRead.substring(dataRead.indexOf("¡")), "").replaceAll("shots:", ""));
    dataRead = dataRead.substring(dataRead.indexOf("¡")).substring(1);

    type = dataRead.replaceAll(dataRead.substring(dataRead.indexOf("¡")), "").replaceAll("type:", "");
    dataRead = dataRead.substring(dataRead.indexOf("¡")).substring(1);

    rounds = int.parse(dataRead.replaceAll(dataRead.substring(dataRead.indexOf("¡")), "").replaceFirst("rounds:", ""));
    dataRead = dataRead.substring(dataRead.indexOf("¡")).substring(1).replaceAll("round:", "");
    List<int> subList = <int>[];

    String number = "";

    for(var i=0; i<dataRead.length;i++){
      switch (dataRead[i]){
        case "{" "}":
          break;
        case "[":
          subList = <int>[];
          number = "";
          break;
        case "]":
          subList.add(int.parse(number));
          round.add(subList);
          number = "";
          break;
        case ",":
          subList.add(int.parse(number));
          number = "";
          break;
        default:
          if(dataRead[i] != "{" && dataRead[i] != "}" && dataRead[i] != "[" && dataRead[i] != "]" && dataRead[i] != ","){
            number = number + dataRead[i];
          }
          break;
      }
    }

    loadTrainingSesions.add(TrainingSesion(StringToDate(date), type, shots, round));

  }
  return loadTrainingSesions;
}


DateTime StringToDate(String date){
  int year, month, day, hour, min, sec, millsec;

  date = date.replaceAll("-", "¡");
  date = date.replaceAll(" ", "¡");
  date = date.replaceAll(":", "¡");
  date = date.replaceAll(".", "¡");

  //print("___________ test String to Date_________");
  year = int.parse(date.replaceAll(date.substring(date.indexOf("¡")),""));
  date = date.substring(date.indexOf("¡")).substring(1);
  //print("year $year");
  month = int.parse(date.replaceAll(date.substring(date.indexOf("¡")),""));
  date = date.substring(date.indexOf("¡")).substring(1);
  //print("month $month");
  day = int.parse(date.replaceAll(date.substring(date.indexOf("¡")),""));
  date = date.substring(date.indexOf("¡")).substring(1);
  //print("day $day");
  hour = int.parse(date.replaceAll(date.substring(date.indexOf("¡")),""));
  date = date.substring(date.indexOf("¡")).substring(1);
  //print("hour $hour");
  min = int.parse(date.replaceAll(date.substring(date.indexOf("¡")),""));
  date = date.substring(date.indexOf("¡")).substring(1);
  //print("min $min");
  sec = int.parse(date.replaceAll(date.substring(date.indexOf("¡")),""));
  date = date.substring(date.indexOf("¡")).substring(1);
  //print("sec $sec");
  millsec = int.parse(date);
  //print("millsec $millsec");

  return DateTime.utc(year,month,day,hour,min,sec,millsec);
}

//____________________________ Utilities _____________________________________

//Imprime en consola todos los directorios y archivos contenidos en el folder principal de programa
void getPathsProgram() async{
  final directory = await getApplicationDocumentsDirectory().then(
          (directory) async {
        List<String> paths = await _listPathsAndFilesInFolder(directory.path);
        String aplicationPath = directory.path;
        print("____________________________________");
        print("in= " + directory.path);
        print("lenght= " + paths.length.toString());
        paths.forEach((element) {print(element);});
      });
}

//Imprime en consola todos los archivos contenidos en el folder de información
void getPathsDatas() async{
  final directory = await getApplicationDocumentsDirectory().then(
          (directory) async {

        List<String> paths = await _listPathsAndFilesInFolder(directory.path + '/infoSaves');
        String aplicationPath = directory.path;
        print("____________________________________");
        print("in= " + directory.path + '/infoSaves');
        print("lenght= " + paths.length.toString());
        paths.forEach((element) {print(element);});
  });
}

// imprime en consola la información sobre el file especificado
Future<void> readFileInConsole(String pathfile) async {
  final directory = await getApplicationDocumentsDirectory();
  File file = new File(pathfile);
  String nameFile =file.path.replaceAll(directory.path.toString()+"/infoSaves/", "");
  nameFile = nameFile.replaceAll(".txt", "");
  String dataRead = await file.readAsString();
  print("nameFile: "+nameFile);
  print(dataRead);
}

// imprime en consola la información sobre todos los files dentro del path especificado
Future<void> readFilesInConsole() async {
  List<File> files = <File>[];
  final directory = await getApplicationDocumentsDirectory();
  List<String> filesPaths = await _listPathsAndFilesInFolder(directory.path + '/infoSaves');
  filesPaths.forEach((filepath) {
     files.add(new File(filepath));
  });
  print("__________________");
  files.forEach((file) async {
    String nameFile =file.path.replaceAll(directory.path.toString()+"/infoSaves/", "");
    nameFile = nameFile.replaceAll(".txt", "");
    String dataRead = await file.readAsString();
    print("nameFile: "+nameFile);
    print(dataRead);
    print("------------------");
  });
}

Future<void> readPathFilesInConsole() async {
  List<File> files = <File>[];
  final directory = await getApplicationDocumentsDirectory();
  List<String> filesPaths = await _listPathsAndFilesInFolder(directory.path + '/infoSaves');
  filesPaths.forEach((filepath) {
    print(filepath);
  });
}






TrainingSesion sesion = new TrainingSesion(DateTime.now(), "points", 3, [[10,10,10]]);
class widgetsFloatingButtonsFiles extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScrollableWidget(
        child: Row(
          children: [
            FloatingActionButton(
              tooltip: "Listar folders",
              onPressed: (){
                getPathsProgram();
              },
              child: Icon(Icons.folder_copy),
            ),
            FloatingActionButton(
              tooltip: "Delete folder",
              onPressed: (){
                deleteFolder("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves");
              },
              child: Icon(Icons.folder_delete_outlined),
            ),
            FloatingActionButton(
              tooltip: "Listar files saved",
              onPressed: (){
                getPathsDatas();
              },
              child: Icon(Icons.snippet_folder),
            ),
            FloatingActionButton(
              tooltip: "add folder",
              onPressed: (){
                createFolder("/data/user/0/com.GSmart.archery_statistics/app_flutter", "infoSaves");
              },
              child: Icon(Icons.create_new_folder),
            ),
            FloatingActionButton(
              tooltip: "add File",
              onPressed: (){
                sesion = new TrainingSesion(DateTime.now(), "points", 3, [[10,10,10]]);
                createFile("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves", sesion);
              },
              child: Icon(Icons.add_box),
            ),
            FloatingActionButton(
              tooltip: "Delete file",
              onPressed: (){
                deleteFile("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves/2023-02-21_164122480.txt");
              },
              child: Icon(Icons.remove_circle_outline),
            ),
            FloatingActionButton(
              tooltip: "save data in file",
              onPressed: (){
                /*sesions.forEach((sesion) {
                  saveData("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves/", sesion);
                });*/
                saveData("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves/", sesion);
              },
              child: Icon(Icons.save_as),
            ),
            FloatingActionButton(
              tooltip: "read file",
              onPressed: () async {
                //readPathFilesInConsole();
                readFilesInConsole();
                /*final ts = await readFilesInTrainingSesions();
                print(ts.length);
                print("_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=_=");

                ts.forEach((sesionts){
                  print(sesionts.name);
                  print(sesionts.date);
                  print(sesionts.type);
                  print(sesionts.shots);
                  print(sesionts.score);
                  print(sesionts.rounds);
                  String vRounds = "{";
                  sesion.round.forEach((shotsRound) {
                    vRounds = vRounds+"[";
                    shotsRound.forEach((element) {
                      vRounds = vRounds + element.toString()+",";
                    });
                    vRounds = vRounds.substring(0,vRounds.length-1);
                    vRounds = vRounds+"]";
                  });
                  vRounds = vRounds+"}";
                  print(vRounds);
                  print("_________________________");
                });*/
                //readFileInConsole("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves/"+sesion.name+".txt");
              },
              child: Icon(Icons.article),
            ),
            FloatingActionButton(
              tooltip: "manual save data in file",
              onPressed: (){
                manualSave("/data/user/0/com.GSmart.archery_statistics/app_flutter/infoSaves/",sesions);
              },
              child: Icon(Icons.save_alt),
            ),
          ],
        ),
    );

  }
}

void manualSave(String filePath, List<TrainingSesion> sesions){
  sesions.forEach((sesion) {
    saveData(filePath, sesion);
    /*print(sesion.date);
    if(sesion.date.month<10){
      print("0"+sesion.date.month.toString());
    }

    print(sesion.date.year.toString() +"-"+ sesion.date.month.toString() +"-"+ sesion.date.day.toString() +" "+ sesion.date.hour.toString() +":"+sesion.date.minute.toString()+":"+(sesion.date.second+1).toString()+"."+sesion.date.millisecond.toString());
    print("____________");*/

  });
}
