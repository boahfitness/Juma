import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';

class RecommendedSection extends StatelessWidget {
  final List<Program> testPrograms;

  RecommendedSection({@required this.testPrograms});

  @override
  Widget build(BuildContext context) {
    return Column( // recommended section
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:10.0),
          child: Text("Recommended", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        ),
        Container(
          height: 430,
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: testPrograms.length,
            itemBuilder: (context, index) {
              Program program = testPrograms[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/program-detail', arguments: program);
                    },
                    child: Hero(
                      tag: program.id,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 350,
                        width: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: ShaderMask(
                            blendMode: BlendMode.color,
                            shaderCallback: (bounds) {
                              var cardGradient = LinearGradient(
                                begin: Alignment.topLeft, end: Alignment.bottomRight,
                                colors: program.theme.gradient.colors,
                                stops: program.theme.gradient.stops
                              );
                              return cardGradient.createShader(bounds);
                            },
                            child: ShaderMask(
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  colors: [Colors.transparent, Colors.black],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 0.5]
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.dstATop,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(program.pathToMedia)
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Hero(
                      tag: "title_${program.id}",
                      child: Text(
                        program.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Hero(
                      tag: "author_${program.id}",
                      child: Text(
                        "${program.author.displayName}"
                      ),
                    )
                  )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}