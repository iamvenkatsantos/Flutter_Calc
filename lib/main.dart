import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double resultFontSize = 48.0;
  double evalutionSize = 38.0;
  String equation = "0";
  String result = "0";
  String expressions = "";
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    List<String> buttons = [
      'C',
      'Del',
      '%',
      '/',
      '9',
      '8',
      '7',
      '*',
      '6',
      '5',
      '4',
      '-',
      '3',
      '2',
      '1',
      '+',
      '.',
      '0',
      '00',
      '='
    ];
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: evalutionSize, color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.black),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
              child: Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemCount: buttons.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return MyButton(
                          Colors.green,
                          Colors.white,
                          buttons[index],
                        );
                      } else if (index == 1) {
                        return MyButton(
                          Colors.redAccent,
                          Colors.white,
                          buttons[index],
                        );
                      } else {
                        return MyButton(
                          isOperator(buttons[index])
                              ? Colors.white
                              : Colors.deepPurple,
                          isOperator(buttons[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple[50],
                          buttons[index],
                        );
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '*' ||
        x == '-' ||
        x == '+' ||
        x == '-' ||
        x == '/' ||
        x == '=') {
      return true;
    }
    return false;
  }

  Widget MyButton(color, textColor, String buttonText) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: color,
          child: FlatButton(
              onPressed: () => buttonPressd(buttonText),
              child: Center(
                child: Text(buttonText,
                    style: TextStyle(color: textColor, fontSize: 20.0)),
              )),
        ),
      ),
    );
  }

  buttonPressd(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        resultFontSize = 48.0;
        evalutionSize = 38.0;
      } else if (buttonText == 'Del') {
        resultFontSize = 38.0;
        evalutionSize = 48.0;
        if (equation == '') {
          equation = '0';
        } else if (equation != '0') {
          equation = equation.substring(0, equation.length - 1);
        }
      } else if (buttonText == '=') {
        resultFontSize = 48.0;
        evalutionSize = 38.0;
        expressions = equation;
        try {
          Parser p = Parser();
          Expression exp = p.parse(expressions);
          ContextModel contextModel = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, contextModel)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        resultFontSize = 38.0;
        evalutionSize = 48.0;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
}
