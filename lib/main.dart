import 'package:flutter/material.dart';
import 'component/button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var inputQ = '';
  var outputQ = '';

  final List<String> btn = [
    'C',
    'Del',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'Ans',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    inputQ,
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    outputQ,
                    style: TextStyle(fontSize: 28),
                  ),
                )
              ],
            ),
          )),
          Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 0.8,
                child: Container(
                  height: 10,
                  child: GridView.builder(
                      itemCount: btn.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext contex, int index) {
                        // C button
                        if (index == 0) {
                          return Button(
                            btnTap: () {
                              setState(() {
                                inputQ = '';
                                outputQ = '';
                              });
                            },
                            btnTxt: btn[index],
                            color: Colors.lightGreen,
                            txtColor: Colors.white,
                          );
                        }
                        // Del button
                        else if (index == 1) {
                          return Button(
                            btnTap: () {
                              setState(() {
                                inputQ = inputQ.substring(0, inputQ.length - 1);
                              });
                            },
                            btnTxt: btn[index],
                            color: Colors.redAccent,
                            txtColor: Colors.white,
                          );
                        }
                        // = button
                        else if (index == btn.length - 1) {
                          return Button(
                            btnTap: () {
                              setState(() {
                                eqPress();
                              });
                            },
                            btnTxt: btn[index],
                            color: Colors.orangeAccent,
                            txtColor: Colors.white,
                          );
                        }
                        //numbers and operator
                        else {
                          return Button(
                            btnTap: () {
                              setState(() {
                                inputQ += btn[index];
                              });
                            },
                            btnTxt: btn[index],
                            color: isOp(btn[index])
                                ? Colors.orangeAccent
                                : Colors.blueGrey,
                            txtColor: Colors.white,
                          );
                        }
                      }),
                ),
              ))
        ],
      ),
    );
  }

  //method to change color of operators
  bool isOp(String o) {
    if (o == '%' || o == '=' || o == '+' || o == '/' || o == '-' || o == 'x') {
      return true;
    } else
      return false;
  }

  // method to fix equal button
  void eqPress() {
    String finalQ = inputQ;

    finalQ = finalQ.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQ);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    outputQ = eval.toString();
  }
}
