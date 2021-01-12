import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/pages/app/home/util/CustomRectTween.dart';
import 'package:juma/pages/app/routes/baseScaffold.dart';

class ProgramDetail extends StatelessWidget {
  final Program program;
  ProgramDetail({@required this.program});
  
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('pageKey'),
      direction: DismissDirection.horizontal,
      child: BaseScaffold(

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              stretch: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 350,
              flexibleSpace: Hero(
                tag: program.id,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter, end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0xff121212)],
                          stops: [0.7, 0.95]
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.srcATop,
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
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate(
                [
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

                  for (int i = 0; i < 10; i++) Container(width: 100, height: 100, color: program.theme.solid, margin: const EdgeInsets.all(20),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}