import 'package:flutter/material.dart';
import 'package:rug/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:rug/feedback_model.dart';
import 'dart:convert' as convert;

class RugNal extends StatefulWidget {
  @override
  _RugNalState createState() => _RugNalState();
}

class _RugNalState extends State<RugNal> {
  var fo = 0;
  List o = [];
  bool bf = true;
  int SumPrixod = 0;
  int SumRasixod = 0;
  bool bError = false;
  String sError = "";
  List<FeedbackModel> feedbacks = List<FeedbackModel>();

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

  getFeedbackFromSheet() {
    http.get(globals.year).then((raw) {
      var jsonFeedback = convert.jsonDecode(raw.body);
      jsonFeedback.forEach((element) {
        if (element["дата"] != "") {
          FeedbackModel feedbackModel = new FeedbackModel();
          if (element['компания'] == "Руж") {
            feedbackModel.time = element['дата'];
            feedbackModel.compani = element['компания'];
            feedbackModel.nal = element['нал/безнал/другое'];
            feedbackModel.project = element['проект'];
            feedbackModel.whoAndWhat = element['кто - что'];
            feedbackModel.prixod = element['приход'];
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
      globals.ff.reversed.forEach((e) {
        SumRasixod += e.rasixod != "" ? e.rasixod.toInt() : 0;
        SumPrixod += e.prixod != "" ? e.prixod.toInt() : 0;
        fo = (e.prixod != "" ? e.prixod.toInt() : 0) -
            (e.rasixod != "" ? e.rasixod.toInt() : 0) +
            fo;
        o.add(fo);
        bf = false;
      });
      print(SumPrixod);
      print(SumRasixod);
      setState(() {});
    }).catchError((error) {
      bError = true;
      sError = "Error: $error";
      print(sError);
      setState(() {});
    });
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
          backgroundColor: Colors.redAccent,
          title: Text("остаток: ${num(SumPrixod - SumRasixod)}"),
          elevation: 0,
        ),
        body: globals.ff != null && globals.ff.isNotEmpty && o.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: DataTable(
                          columnSpacing: 10,
                          columns: const <DataColumn>[
                            DataColumn(label: Text('дата')),
                          DataColumn(label: Text('проект')),
                            DataColumn(
                              label: Text("приход"),
                              numeric: true,
                            ),
                            DataColumn(label: Text("расход"), numeric: true),
                            DataColumn(label: Text('кто - что')),
                            DataColumn(label: Text("остаток"), numeric: true),


                        ],
                        rows: List<DataRow>.generate(
                          globals.ff.length,
                          (int i) => DataRow(
                            cells: <DataCell>[
                              DataCell(Container(
                                  width: 40,
                                  child: Text(
                                      "${globals.ff.elementAt(i).time.toString().split("T").elementAt(0).toString().split("-").elementAt(1) + "." + globals.ff.elementAt(i).time.toString().split("T").elementAt(0).toString().split("-").elementAt(2)}",
                                      softWrap: true))),
                              DataCell(Container(
                                  width: 90,
                                  child: Text(
                                      "${globals.ff.elementAt(i).project}",
                                      softWrap: true))),
                              DataCell(Text(
                                  "${globals.ff.elementAt(i).prixod != "" ? num(globals.ff.elementAt(i).prixod.toInt()) : ""}")),
                              DataCell(Text(
                                  "${globals.ff.elementAt(i).rasixod != "" ? num(globals.ff.elementAt(i).rasixod.toInt()) : ""}")),
                              DataCell(Container(
                                  width: 80,
                                  child: Text(
                                      "${globals.ff.elementAt(i).whoAndWhat}",
                                      softWrap: true))),
                              DataCell(Text("${num(o.reversed.elementAt(i))}")),
                            ],
                          ),
                        ),
                      ),)
                    )))
            : !bError
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.redAccent,
                      strokeWidth: 5,
                    ),
                  )
                : Center(
                    child: Container(child: Text(sError)),
                  ));
  }
}
