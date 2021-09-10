import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rug/globals.dart' as globals;
import 'dart:convert' as convert;
import 'package:rug/feedback_model.dart';
import 'MontashProject.dart';

class Mantash extends StatefulWidget {
  @override
  _MantashState createState() => _MantashState();
}

class _MantashState extends State<Mantash> {
  bool bError = false;
  String sError = "";
  List<FeedbackModel> feedbacks = List<FeedbackModel>();
  Map d = {};
  var SumRasixod = 0.0;
  var SumPrixod = 0.0;

  getFeedbackFromSheet() {
    http.get(globals.year).then((raw) {
      var jsonFeedback = convert.jsonDecode(raw.body);
      jsonFeedback.forEach((element) {
        if (element["дата"] != "") {
          FeedbackModel feedbackModel = new FeedbackModel();
          if (element['проект'] != "оплачено" && globals.H.contains(element['компания'])) {
            if (!globals.h.contains(element['проект'])) {
              globals.h.add(element['проект']);
              d[element['проект']] = [
                (element['расход'] != "" ? element['расход'].toInt() : 0),
                (element['приход'] != "" ? element['приход'].toInt() : 0)
              ];
            } else {
              d[element['проект']][0] +=
                  element['расход'] != "" ? element['расход'].toInt() : 0;
              d[element['проект']][1] +=
                  element['приход'] != "" ? element['приход'].toInt() : 0;
            }
            feedbackModel.time = element['дата'];
            feedbackModel.compani = element['компания'];
            feedbackModel.nal = element['нал/безнал/другое'];
            feedbackModel.project = element['проект'];
            feedbackModel.whoAndWhat = element['кто - что'];
            feedbackModel.prixod = element['приход'];
            SumRasixod +=
                element['расход'] != "" ? element['расход'].toDouble() : 0;
            SumPrixod +=
                element['приход'] != "" ? element['приход'].toDouble() : 0;
            feedbackModel.rasixod = element['расход'];
            feedbackModel.ostatok = element['остаток'];
            feedbackModel.vid = element['вид расходов'];
            feedbackModel.podvid = element['подвид'];
            feedbackModel.ytoch = element['уточнения'];
            feedbackModel.inPer = element['внутренняя переписка'];
            feedbackModel.sumDogovor = element['сумма договора'];
            feedbackModel.numDogovor = element['номер договора'];
            feedbacks.add(feedbackModel);
            globals.ff.add(feedbackModel);
          }
        }
      });
      setState(() {});
    }).catchError((error) {
      bError = true;
      sError = "Error: $error";
      print(sError);
      setState(() {});
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
    globals.h = [];
    globals.ff = [];
    getFeedbackFromSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("остаток:   ${num(SumPrixod.toInt() - SumRasixod.toInt())}"),
          elevation: 0,
        ),
        body: globals.h != null && globals.h.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: 20,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('проект')),
                        DataColumn(label: Text('приход'), numeric: true),
                        DataColumn(label: Text('расход'), numeric: true),
                      ],
                      rows: List<DataRow>.generate(
                        globals.h.length,
                        (int i) => DataRow(
                          cells: <DataCell>[
                            DataCell(Container(
                                width: 100,
                                child: Text("${globals.h.elementAt(i)}",
                                    softWrap: true)), onTap: (){
                              globals.n = i;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Project()));
                            }),
                            DataCell(Text(
                                    "${num(d[globals.h.elementAt(i)][1].toInt())}"), onTap: (){
                              globals.n = i;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Project()));
                            }),
                            DataCell(Text(
                                    "${num(d[globals.h.elementAt(i)][0].toInt())}"), onTap: (){
                              globals.n = i;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Project()));
                            }),
                          ],
                        ),
                      ),
                    )))
            : !bError
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.cyan,
                      strokeWidth: 5,
                    ),
                  )
                : Center(
                    child: Container(child: Text(sError)),
                  ));
  }
}
