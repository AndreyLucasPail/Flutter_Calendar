
class TaskModel {
  TaskModel({
    this.task,
    this.day,
    this.date,
    this.id,
    this.month
  });

  String? task;
  int? day;
  String? date;
  int? id;
  int? month;

  factory TaskModel.fromJson(Map<String, dynamic> json){
    return TaskModel(
      task : json["taskColumn"], 
      day: json["dayColumn"],
      date: json["dateColumn"],
      id: json["idColumn"],
      month: json["monthColumn"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "taskColumn" : task,
      "dayColumn" : day,
      "dateColumn" : date,
      "idColumn" : id,
      "monthColumn" : month,
    };
  }
}