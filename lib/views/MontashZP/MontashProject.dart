import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rug/views/vid.dart';
import 'package:rug/globals.dart' as globals;
import 'dart:math';

class Project extends StatefulWidget {
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  Map<String, List> data = {};
  double sumRasixod = 0;

  Map<String, double> dataMap = {};
  List colorList = <Color>[];

  Color randomColor() {
    Random random = Random();

    return Color.fromARGB(
        255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
  }

  kkk() {
    globals.ff.forEach((n) {
      if (n.project == globals.h.elementAt(globals.n)) {
        if (data.containsKey(n.vid)) {
          data[n.vid][0] +=
              n.rasixod.runtimeType == int || n.rasixod.runtimeType == double
                  ? n.rasixod
                  : 0;
        } else {
          //--------------------------------------------------------------------
          data[n.vid] = [];
          data[n.vid].add(
              n.rasixod.runtimeType == int || n.rasixod.runtimeType == double
                  ? n.rasixod
                  : 0);
          colorList.add(randomColor());
        }
        sumRasixod +=
            n.rasixod.runtimeType == int || n.rasixod.runtimeType == double
                ? n.rasixod
                : 0;
      }
    });
    data.keys.forEach((e) {
      dataMap[e] = sumRasixod != 0 && data[e][0] != 0
          ? data[e][0] / (sumRasixod / 100)
          : 0;
    });
  }

  String num(int n) {
    var i = 1;
    var result = "";
    while (i * 3 <= n.toString().length) {
      result = (" " +
              n.toString().substring(n.toString().length - (3 * i),
                  n.toString().length - (3 * (i - 1)))) +
          result;
      i += 1;
    }
    return n.toString().substring(0, n.toString().length % 3) + result;
  }

  @override
  void initState() {
    kkk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(globals.h.elementAt(globals.n)),
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "расход: ${num(sumRasixod.toInt())}",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dataRowHeight: 50,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('Вид расходов'),
                          numeric: false,
                          tooltip: "это вид расходов",
                        ),
                        DataColumn(
                          label: Text("расход"),
                          tooltip: "это расход",
                          numeric: true,
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        data.keys.length,
                        (int index) => DataRow(
                          cells: <DataCell>[
                            DataCell(Container(
                              width: 200,
                              child: Text(
                                '${data.keys.elementAt(index)}',
                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, -5))
                                  ],
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: colorList[index],
                                  decorationThickness: 3,
                                ),
                                softWrap: true,
                              ),
                            )
                                //     Text(
                                //   '${data.keys.elementAt(index)}',
                                // )
                                ),
                            DataCell(
                                Text(
                                    '${num(data[data.keys.elementAt(index)][0].toInt())} ₽'),
                                onTap: () {
                              globals.vid = data.keys.elementAt(index);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => vids()));
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ])
        ]));
  }
}
