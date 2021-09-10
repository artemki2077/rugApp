import 'package:flutter/material.dart';
import 'package:rug/globals.dart' as globals;
import 'home.dart';
import 'MontashZP/Montash_ZP.dart';
import 'RujNal/RujNal.dart';

class Year extends StatefulWidget {
  @override
  _YearState createState() => _YearState();
}

class _YearState extends State<Year> {

  @override
  void initState() {
    super.initState();
  }

  List<Widget> kk() {
    List<Widget> yearButtons = <Widget>[];
    var n = globals.years.keys.length;
    for (var i = 0; i < n; i++) {
      yearButtons.add(
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: ElevatedButton(
              onPressed: () {
                globals.year = globals.years.values.elementAt(i);
                globals.y = i;
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                  textStyle:
                  MaterialStateProperty.all(TextStyle(fontSize: 30))),
              child: Container(
                  width: 200,
                  child: Center(
                      child: Text("${globals.years.keys.elementAt(i)}")))),
        ),
      );
    }
    yearButtons.add(Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: ElevatedButton(
          onPressed: () {
            globals.year = globals.years.values.elementAt(1);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Mantash()));
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              textStyle:
              MaterialStateProperty.all(TextStyle(fontSize: 30))),
          child: Container(
              width: 200,
              child: Center(
                  child: Text("Монтаж ЗП (2021)", style: TextStyle(fontSize: 16),)))),
    ),);
    return yearButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Года"),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SizedBox(
            width: double.infinity,
            child: ListView(children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Center(
                    child: Column(
                      children: kk(),
                    )),
              )
            ])));
  }
}
