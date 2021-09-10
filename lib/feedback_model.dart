class FeedbackModel {




  var time;
  var compani;
  var nal;
  var project;
  var whoAndWhat;
  var prixod;
  var rasixod;
  var ostatok;
  var vid;
  var podvid;
  var ytoch;
  var inPer;
  var sumDogovor;
  var numDogovor;






  FeedbackModel(
      {this.time, this.compani, this.nal, this.project, this.whoAndWhat, this.prixod,
        this.rasixod, this.ostatok, this.vid, this.podvid, this.ytoch,
        this.inPer, this.sumDogovor, this.numDogovor});

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel(
      time: "${json['дата']}",
      compani: "${json['компания']}",
      nal: "${json['нал/безнал/другое']}",
      project: "${json['проект']}",
      whoAndWhat: "${json['кто - что']}",
      prixod: "${json['приход']}",
      rasixod: "${json['расход']}",
      ostatok: "${json['остаток']}",
      vid: "${json['вид расходов']}",
      podvid: "${json['подвид']}",
      ytoch: "${json['уточнения']}",
      inPer: "${json['внутренняя переписка']}",
      sumDogovor: "${json['сумма договора']}",
      numDogovor: "${json['номер договора']}"
    );
  }

  Map toJson() => {
    "дата":time ,
    "компания":compani,
    "нал/безнал/другое": nal,
    "проект": project,
    "кто - что": whoAndWhat,
    "приход": prixod,
    "расход": rasixod,
    "остаток": ostatok,
    "вид расходов": vid,
    "подвид": podvid,
    "уточнения": ytoch,
    "внутренняя переписка": inPer,
    "сумма договора": sumDogovor,
    "номер договора": numDogovor
  };
}