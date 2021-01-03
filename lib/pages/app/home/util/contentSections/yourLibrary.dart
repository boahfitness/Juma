import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/pages/app/home/util/programDecal.dart';

class YourLibrarySection extends StatelessWidget {
  final List<Program> testPrograms;

  YourLibrarySection({@required this.testPrograms});

  @override
  Widget build(BuildContext context) {
    return Column( // your library section
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:10.0, bottom: 10),
              child: Text("Your Library", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            ),
          ],
        ),
        Container(
          height: 140,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: testPrograms.length,
            itemBuilder: (context, index) {
              var program = testPrograms.reversed.toList()[index];
              return ProgramDecal(
                ProgramDescriptor(
                  author: program.author,
                  title: program.title,
                  pathToMedia: program.pathToMedia,
                  theme: program.theme,
                  description: program.description
                ),
                width: 140,
              );
            },
          ),
        )
      ],
    );
  }
}