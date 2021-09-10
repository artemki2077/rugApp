import 'package:flutter/material.dart';
import 'package:rug/views/controller.dart';
import 'package:rug/views/model/form.dart';
import 'dart:math' as math;

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController timeController = TextEditingController();
  TextEditingController companiController = TextEditingController();
  TextEditingController nalController = TextEditingController();
  TextEditingController projectController = TextEditingController();
  TextEditingController whoAndWhatController = TextEditingController();
  TextEditingController prixodController = TextEditingController();
  TextEditingController rasixodController = TextEditingController();
  TextEditingController ostatokController = TextEditingController();
  TextEditingController vidController = TextEditingController();
  TextEditingController podvidController = TextEditingController();
  TextEditingController ytochController = TextEditingController();
  TextEditingController inPerController = TextEditingController();
  TextEditingController sumDogovorController = TextEditingController();
  TextEditingController numDogovorController = TextEditingController();

  void _submitForm() {
      FeedbackForm feedbackForm = FeedbackForm(
          timeController.text,
          companiController.text,
          nalController.text,
          projectController.text,
          whoAndWhatController.text,
          prixodController.text,
          rasixodController.text,
          ostatokController.text,
          vidController.text,
          podvidController.text,
          ytochController.text,
          inPerController.text,
          sumDogovorController.text,
          numDogovorController.text);

      FormController formController = FormController((String response) {
        if (response == FormController.STATUS_SUCCESS) {
          //
          _showSnackbar("отправилось усипешно");
        } else {
          _showSnackbar("не отправилось");
        }
      });
      formController.submitForm(feedbackForm);
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget form(String name, Icon icon, TextEditingController _controller) {
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: name,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            prefixIcon: icon,
          ),
          controller: _controller,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("добавить в таблицу"),
          elevation: 0,
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                child: Form(
                    key: _formKey,
                    child: ListView(
                  children: <Widget>[
                    form("дата(дд.мм.гггг)", Icon(Icons.access_time), timeController),
                    form(
                        "компания", Icon(Icons.account_box_rounded), companiController),
                    form("нал/безнал/другое",
                        Icon(Icons.account_balance_wallet), nalController),
                    form(
                        "проект", Icon(Icons.account_balance_sharp), projectController),
                    form("кто - что", Icon(Icons.extension_rounded),
                        whoAndWhatController),
                    form("приход", Icon(Icons.add), prixodController),
                    form("расход", Icon(Icons.remove),
                        rasixodController),
                    form("остаток", Icon(Icons.monetization_on), ostatokController),
                    form("вид расходов", Icon(Icons.ballot), vidController),
                    form(
                        "подвид", Icon(Icons.arrow_drop_down_circle), podvidController),
                    form("уточнения", Icon(Icons.add_box_rounded), ytochController),
                    form("внутренняя переписка", Icon(Icons.archive), inPerController),
                    form("сумма договора", Icon(Icons.money), sumDogovorController),
                    form("номер договора", Icon(Icons.format_list_numbered),
                        numDogovorController),
                    Transform.rotate(
                        angle: 1.5 * math.pi,
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_drop_down_circle_rounded,
                            ),
                            iconSize: 65,
                            color: Colors.indigo,
                            tooltip: 'войти',
                            onPressed: _submitForm,))
                  ],
                )))));
  }
}
