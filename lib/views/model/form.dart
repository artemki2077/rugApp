class FeedbackForm {
  String _time;
  String _compani;
  String _nal;
  String _project;
  String _whoAndWhat;
  String _prixod;
  String _rasixod;
  String _ostatok;
  String _vid;
  String _podvid;
  String _ytoch;
  String _inPer;
  String _sumDogovor;
  String _numDogovor;

  FeedbackForm(
      this._time,
      this._compani,
      this._nal,
      this._project,
      this._whoAndWhat,
      this._prixod,
      this._rasixod,
      this._ostatok,
      this._vid,
      this._podvid,
      this._ytoch,
      this._inPer,
      this._sumDogovor,
      this._numDogovor
      );


  Map<String, String> toParams() => <String, String>{
        "time": _time,
        "compani": _compani,
        "nal": _nal,
        "project": _project,
        "whoAndWhat": _whoAndWhat,
        "prixod": _prixod,
        "rasixod": _rasixod,
        "ostatok": _ostatok,
        "vid": _vid,
        "podvid": _podvid,
        "ytoch": _ytoch,
        "inPer": _inPer,
        "sumDogovor": _sumDogovor,
        "numDogovor": _numDogovor,
      };
}
