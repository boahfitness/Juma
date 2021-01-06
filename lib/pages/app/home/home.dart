import 'package:flutter/material.dart';
import 'package:juma/pages/app/home/util/contentSections/recommended.dart';
import 'package:juma/pages/app/home/util/contentSections/yourLibrary.dart';
import 'package:juma/pages/app/home/util/ui/jumaAppBar.dart';

import 'package:juma/test/data/programsData.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: JumaAppBar(),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            YourLibrarySection(testPrograms: testPrograms),
            RecommendedSection(testPrograms: testPrograms)
          ],
        ),
      ),
    );
  }
}