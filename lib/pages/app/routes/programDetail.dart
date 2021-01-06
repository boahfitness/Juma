import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/pages/app/home/util/CustomRectTween.dart';
import 'package:juma/pages/app/home/util/ui/jumaAppBar.dart';
import 'package:juma/pages/app/routes/baseScaffold.dart';

class ProgramDetail extends StatelessWidget {
  final Program program;
  ProgramDetail({@required this.program});
  
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: EmptyAppBar(),

      backgroundColor: Colors.red,

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red, Colors.black]
          )
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: program.id,
                child: Container(
                  height: 350,
                  width: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ShaderMask(
                      blendMode: BlendMode.color,
                      shaderCallback: (bounds) {
                        return program.theme.gradient.createShader(bounds);
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

              Padding(
                padding: const EdgeInsets.only(left: 0, top: 10),
                child: Hero(
                  createRectTween: (begin, end) {
                    return CustomRectTween(a: begin, b: end, curveTransform: (t) => Cubic(.72,0,.39,.08).transform(t));
                  },
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
                padding: const EdgeInsets.only(left: 0, top: 5),
                child: Hero(
                  createRectTween: (begin, end) {
                    return CustomRectTween(a: begin, b: end, curveTransform: (t) => Cubic(.72,0,.39,.08).transform(t));
                  },
                  tag: "author_${program.id}",
                  child: Text(
                    "${program.author.displayName}"
                  ),
                )
              ),

              for (int i = 0; i < 10; i++) Container(width: 100, height: 100, color: program.theme.accent, margin: const EdgeInsets.all(20),)
            ],
          ),
        ),
      ),
    );
  }
}