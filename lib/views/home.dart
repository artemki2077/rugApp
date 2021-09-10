import 'package:flutter/material.dart';
import 'package:rug/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'add.dart';
import 'package:rug/views/project.dart';
import 'package:rug/globals.dart' as globals;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool bError = false;
  String sError = "";
  List<FeedbackModel> feedbacks = List<FeedbackModel>();

  getFeedbackFromSheet() {
    http.get(globals.year).then((raw) {
      var jsonFeedback = convert.jsonDecode(raw.body);
      jsonFeedback.forEach((element) {
        if(element["дата"] != ""){
        FeedbackModel feedbackModel = new FeedbackModel();
        if (!globals.hhh.contains(element['проект'])) {
          if (!globals.h.contains(element['проект'])) {
            globals.h.add(element['проект']);
          }
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
        }}
      });
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
            title: Text("${globals.years.keys.elementAt(globals.y)}"),
            elevation: 0,
            actions: <Widget>[
                    IconButton(
                      iconSize: 35,
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Add()));
                      },
                    )
                  ]),
        body: globals.h != null && globals.h.isNotEmpty
            ? ListView.builder(
                itemCount: globals.h.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${globals.h[index]}"),
                    onTap: () {
                      globals.n = index;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Project()));
                    },
                  );
                })
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
