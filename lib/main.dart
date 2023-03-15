
import 'package:archery_statistics/models/TrainingSesion.dart';
import 'package:archery_statistics/screens/ListDataForms.dart';
import 'package:archery_statistics/screens/addForm.dart';
import 'package:archery_statistics/widgets/buildDataTable.dart';

import 'package:flutter/material.dart';

import 'DataSaves/LinkedFiles.dart';




void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Archery Statistics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

GlobalKey<BuildDataTableState> keyBuildDataTableSt = GlobalKey();

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
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
        title: Row(
          children: [
            Text(widget.title),
            Spacer(),
            IconButton(
                icon: Icon(Icons.download),
                onPressed: (){
                  trainingSesions.forEach((trainingSesion) {
                    saveData("/storage/emulated/0/Download",trainingSesion);
                  });
                  print("descargando");
                })
          ],
        ),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //widgetsFloatingButtonsFiles(),
            ListDataForms(trainingSesionslist: trainingSesions,),
          ],
        ),
      ),
      floatingActionButton:
      FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 92, 201, 40),

        heroTag: "newForm",
          label: const Text('nuevo registro'),
          icon: const Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return AddForm();
            },
            )).then((value) {
              setState(() {
                keyBuildDataTableSt.currentState?.loadData();
              });
            });
          }
      ),

    );
  }



}
