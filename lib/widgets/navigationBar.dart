


import 'package:archery_statistics/screens/ListDataForms.dart';
import 'package:archery_statistics/screens/addForm.dart';
import 'package:flutter/material.dart';





class NavigationBarScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NavigationBarScreen();
  }
}

int indexTap = 0;
class _NavigationBarScreen extends State<NavigationBarScreen>{

  _onTapTapped(int index){
    setState(() {
      indexTap = index;
    });
  }

  final List<Widget> widgetsScreens = [
    //ListDataForms(),
    AddForm(),
    //ListDataForms(),
  ];



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: widgetsScreens[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.purple,
        ),
        child: Stack(children: [
          Container(
            height: 60.0,
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 5.0,
                    colors: [Colors.white, Colors.lightGreenAccent])
            ),
          ),
          BottomNavigationBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.black,
            onTap: _onTapTapped,
            currentIndex: indexTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "List",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "new form",
              ),
        ],)
          ],
        ),
      ),
    );
  }
}