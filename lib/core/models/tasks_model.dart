import 'package:flutter/cupertino.dart';

class Task {
  int id;
  String task;
  String date;

  Task({this.id, @required this.task, @required this.date});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task = json['task'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> note = Map<String, dynamic>();
    note['id'] = this.id;
    note['task'] = this.task;
    note['date'] = this.date;
    return note;
  }
}
