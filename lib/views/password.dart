import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rug/globals.dart' as globals;
import 'dart:math' as math;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'years.dart';


class Passworrd extends StatefulWidget {
  @override
  _PassworrdState createState() => _PassworrdState();
}

class _PassworrdState extends State<Passworrd> {
  bool isHidden = false;
  String password;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: Center(
            child: Container(
                width: 400,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(

                          obscureText: isHidden,
                          autofillHints: [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          onEditingComplete: () =>
                              TextInput.finishAutofillContext(),
                          onChanged: (e) {
                            password = e;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: isHidden
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: togglePasswordVisibility,
                            ),
                            hintText: "пароль",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            prefixIcon: Icon(Icons.lock),
                          )),),
                      Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: Transform.rotate(
                              angle: 1.5 * math.pi,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle_rounded,
                                  ),
                                  iconSize: 65,
                                  color: Colors.indigo,
                                  tooltip: 'войти',
                                  onPressed: () {
                                    if (sha256.convert(utf8.encode(password))
                                        .toString() ==
                                        "ee09198e46224875cf39928511ef2b855895c43ee86d1de894ee82bc7c990afa") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Year()));
                                    } else if (sha256.convert(utf8.encode(
                                        password))
                                        .toString() ==
                                        "64ef8cbfd4e16b46fba5c355a47cb596c58f876c7e898f2bbf8562f12e35b09a") {
                                      globals.years = {2018: "lol"};
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Year()));
                                    }else{
                                      _showSnackbar("неверный пароль");
                                    }
                                  }
                              )))
                    ]))));
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
