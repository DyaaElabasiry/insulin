import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
//import package file

class MyLiquidProgress extends StatelessWidget {
  final int percent;

   const MyLiquidProgress({super.key, required this.percent});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25),
        height: 300,
        width: 90,
        child: LiquidLinearProgressIndicator(
          value: percent/100,
          // Defaults to 0.5.
          valueColor: AlwaysStoppedAnimation(Color.fromRGBO(170, 163, 255, 1)),
          // Defaults to the current Theme's accentColor.
          backgroundColor: Colors.white,
          // Defaults to the current Theme's backgroundColor.
          borderColor: Color.fromRGBO(135, 126, 252, 1),
          //border color of the bar
          borderWidth: 2,
          //border width of the bar
          borderRadius: 15,
          //border radius
          direction: Axis.vertical,
          // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
          center: Text(
            "${percent}%",
            style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black54),
          ), //text inside bar
        ));
  }
}
// borderColor: Color.fromRGBO(120, 110, 255, 1), //border color of the bar
