import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AuraPicker extends StatefulWidget {
  final bool enabled;
  final double width;
  final String text;
  final void Function() onTap;

  AuraPicker({
    this.enabled=true,
    @required 
    this.width,
    @required 
    this.text,
    this.onTap,
  });

  @override
  _AuraPickerState createState() => _AuraPickerState();
}

class _AuraPickerState extends State<AuraPicker> {
  double size;

  @override
  void initState() {
    size = widget.width;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          size = size * 0.9;
        });
      },
      onTapUp: (details) {
        widget.onTap();
        setState(() {
          size = widget.width;
        });
      },
      child: Container(
        width: widget.width,
        height: widget.width,
        child: Stack(
          children: <Widget>[

            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size * 0.75),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  color: widget.enabled ? Colors.grey[500] : Colors.grey[900],
                  width: size * 0.75,
                  height: size * 0.75,
                ),
              ),
            ),

            Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.enabled ? Colors.black : Colors.grey[500],
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              opacity: widget.enabled ? 1.0 : 0.0,
              child: FlareActor(
                'assets/animations/Aura.flr',
                animation: 'Aura',
              ),
            ),

          ],
        ),
      ),
    );
  }
}