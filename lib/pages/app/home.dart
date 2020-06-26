import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: SizedBox(
          width: 50,
          height: 35,
          child: Container(
            color: Colors.white,
            child: Center(
              child: Text(
                "JUMA", 
                style: TextStyle(color: Colors.black, fontFamily: 'Oswald', fontSize: 15),
              ),
            ),
          )
        ),
      ),

      body: Center(child: Text('HOME'),),

      drawer: Drawer(),
    );
  }
}