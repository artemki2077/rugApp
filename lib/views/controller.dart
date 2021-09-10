import 'dart:convert' as convert;
import 'package:rug/views/model/form.dart';
import 'package:http/http.dart' as http;
import 'package:rug/urls.dart' as secrets;

class FormController {
  final void Function(String) callback;
  var indf = secrets.urlController;
  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    var url = Uri.https(
        "script.google.com",
        "macros/s/" + indf + "/exec",
        feedbackForm.toParams());
    try {
      await http.get(url).then((response) {
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      callback("error");
    }
  }
}
