import 'package:flutter/material.dart';
import 'package:rug/views/vid.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:rug/globals.dart' as globals;
import 'dart:math';

class Project extends StatefulWidget {
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  Map<String, List> data = {};
  double obnimashki = 0;
  double paid = 0;
  double sumDogovor = 0;
  double sumRasxod = 0;
  double sumPrixod = 0;
  double sumNal = 0;
  Map<String, double> dataMap = {};
  List colorList = <Color>[];
  List<String> listKey = <String>[];

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
          dataMap[n.vid] +=
              n.rasixod.runtimeType == int || n.rasixod.runtimeType == double
                  ? n.rasixod.toDouble()
                  : 0;
        } else if (n.vid != ".приход по проекту") {
          //--------------------------------------------------------------------
          data[n.vid] = [];
          data[n.vid].add(
              n.rasixod.runtimeType == int || n.rasixod.runtimeType == double
                  ? n.rasixod
                  : 0);
          dataMap[n.vid] =
              n.rasixod.runtimeType == int || n.rasixod.runtimeType == double
                  ? n.rasixod.toDouble()
                  : 0.toDouble();
          colorList.add(randomColor());
        }
        sumRasxod +=
            n.rasixod.runtimeType == int || n.rasixod.runtimeType == double
                ? n.rasixod.toDouble()
                : 0.toDouble();
        sumPrixod +=
            n.prixod.runtimeType == int || n.prixod.runtimeType == double
                ? n.prixod
                : 0;
        if (n.vid == ".приход по проекту") {
          paid += n.prixod.runtimeType == int || n.prixod.runtimeType == double
              ? n.prixod
              : 0;
          sumDogovor += n.sumDogovor.runtimeType == int ||
                  n.sumDogovor.runtimeType == double
              ? n.sumDogovor
              : 0;
        }
        if (n.nal == "нал") {
          // if(n.rasixod.runtimeType != int && n.rasixod.runtimeType != double){
          //   print(n.rasixod);
          //   print(n.vid);
          // }
          sumNal +=
              n.rasixod.runtimeType == int || n.rasixod.runtimeType == double
                  ? n.rasixod
                  : 0;
        }
      }
    });
    data["6% налоги"] = [sumDogovor * 0.06];
    dataMap["6% налоги"] = (sumDogovor * 0.06).toDouble();
    colorList.add(randomColor());
    data["3% на фирму"] = [sumDogovor * 0.03];
    dataMap["3% на фирму"] = sumDogovor * 0.03;
    colorList.add(randomColor());
    data["10% на обнял"] = [sumNal * 0.1];
    dataMap["10% на обнял"] = sumNal * 0.1;
    colorList.add(randomColor());
    sumRasxod += data["6% налоги"][0];
    sumRasxod += data["3% на фирму"][0];
    sumRasxod += data["10% на обнял"][0];
    dataMap.keys.forEach((e) {
      dataMap[e] = sumRasxod != 0 && dataMap[e] != 0
          ? dataMap[e] / (sumRasxod / 100)
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

  Widget row(String name, var n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(name),
        Text(":"),
        Text("${num(n.toInt())} ₽"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(globals.h.elementAt(globals.n)),
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          !globals.hhhh.contains(globals.h.elementAt(globals.n))
              ? Center(
                  child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      row("Сумма договора", sumDogovor),
                      row("заплатили     ", paid),
                      row("потрачено     ", sumRasxod),
                      row("остаток      ", (sumDogovor - sumRasxod)),
                      row("ещё заплатят  ", (sumDogovor - paid)),
                    ],
                  ),
                ))
              : Center(
                  child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      Text("потрачено  :  ${sumRasxod.toInt()}"),
                    ],
                  ),
                )),
          Padding(
            padding: EdgeInsets.all(150.0),
            child: Container(
              child: PieChart(
                dataMap: dataMap,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 300,
                legendOptions: LegendOptions(
                  showLegends: false,
                ),
                chartValuesOptions: ChartValuesOptions(
                  chartValueStyle: TextStyle(
                    fontSize: 20,
                  ),
                  decimalPlaces: 0,
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: true,
                ),
              ),
            ),
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 10,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('Вид расходов'),
                          numeric: false,
                          tooltip: "это вид расходов",
                        ),
                        DataColumn(
                          label: Text("Расход"),
                          tooltip: "это раскаод",
                          numeric: true,
                        ),
                        DataColumn(
                          label: Text("проценты"),
                          tooltip: "это проценты",
                          numeric: true,
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        data.keys.length,
                        (int index) => DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Container(
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
                                  decorationThickness: 4,
                                ),
                                  softWrap: true,
                              ),)
                              //     Text(
                              //   '${data.keys.elementAt(index)}',
                              // )
                            ),
                            DataCell(Text(
                                        '${num(data[data.keys.elementAt(index)][0].toInt())} ₽',),
                                onTap: () {
                              globals.vid = data.keys.elementAt(index);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => vids()));
                            }),
                            DataCell(Text(
                                "${dataMap[data.keys.elementAt(index)].toInt()} %")),
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
