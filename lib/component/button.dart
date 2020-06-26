import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final color;
  final txtColor;
  final String btnTxt;
  final btnTap;

  Button({this.color, this.txtColor, this.btnTxt,this.btnTap});

  @override
  Widget build(BuildContext context) {
    //var h = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: btnTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child:
                  Text(btnTxt, style: TextStyle(color: txtColor, fontSize: 22)),
            ),
          ),
        ),
      ),
    );
  }
}
