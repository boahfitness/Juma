import 'package:flutter/material.dart';

List<Page> getPages() {
  return [
    Page(title: 'Onboarding page 1', desc: "You'll get swole AF"),
    Page(title: 'Onboarding page 2', desc: "And you'll get strong AF"),
    Page(title: 'Onboarding page 3', desc: "but you gotta put in the work")
  ];
}

class Page extends StatelessWidget {
  final String title, desc;
  
  Page({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Text(title),
          ),
          SizedBox(height: 30,),
          Center(
            child: Text(desc),
          ),
        ],
      ),
    );
  }
}