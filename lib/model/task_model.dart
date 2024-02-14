
class TaskModel {
  TaskModel({
    this.task,
    this.day,
    this.dateTime,
    this.id,
    this.month
  });

  String? task;
  int? day;
  DateTime? dateTime;
  int? id;
  int? month;

  factory TaskModel.fromJson(Map<String, dynamic> json){
    return TaskModel(
      task : json["task"], 
      day: json["day"],
      dateTime: json["dateTime"],
      id: json["id"],
      month: json["month"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "task" : task,
      "day" : day,
      "dateTime" : dateTime!.toIso8601String(),
      "id" : id,
      "month" : month,
    };
  }
}