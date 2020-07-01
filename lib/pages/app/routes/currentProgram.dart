import 'package:flutter/material.dart';

class CurrentProgram extends StatefulWidget {
  @override
  _CurrentProgramState createState() => _CurrentProgramState();
}

class _CurrentProgramState extends State<CurrentProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        //backgroundColor: Colors.grey[900].withOpacity(0.2),
        backgroundColor: Colors.transparent,
      ),

      body: Center(
        child: Text('CURRENT PROGRAM'),
      ),
    );
  }
}