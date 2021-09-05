// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.method,
    this.status,
    this.results,
  });

  String method;
  bool status;
  List<Result> results;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        method: json["method"],
        status: json["status"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.title,
    this.thumb,
    this.key,
    this.times,
    this.portion,
    this.dificulty,
  });

  String title;
  String thumb;
  String key;
  String times;
  String portion;
  String dificulty;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        thumb: json["thumb"],
        key: json["key"],
        times: json["times"],
        portion: json["portion"],
        dificulty: json["dificulty"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumb": thumb,
        "key": key,
        "times": times,
        "portion": portion,
        "dificulty": dificulty,
      };
}
