
class TaskModel {
  TaskModel({
    this.task,
    this.dateTime,
  });

  String? task;
  DateTime? dateTime;

  factory TaskModel.fromJson(Map<String, dynamic> json){
    return TaskModel(
      task : json["task"], 
      dateTime: json["dateTime"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "task" : task,
      "dateTime" : dateTime!.toIso8601String(),
    };
  }
}