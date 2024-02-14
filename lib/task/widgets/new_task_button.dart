import 'package:flutter/material.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/model/task_model.dart';

class NewTaskButton extends StatefulWidget {
  const NewTaskButton({super.key, this.day, this.month});

  final int? day;
  final int? month;

  @override
  State<NewTaskButton> createState() => _NewTaskButtonState();
}

class _NewTaskButtonState extends State<NewTaskButton> {

  final TextEditingController taskController = TextEditingController();
  DataBaseHelper helper = DataBaseHelper();

  @override
  void initState() {
    super.initState();

    helper.initDb();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        showModalBottomSheet(
          backgroundColor: Colors.black,
          context: context, 
          builder: (context){
            return Card(
              color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [                      
                      TextFormField(
                        controller: taskController,
                        decoration: const InputDecoration(
                          labelText: "Nova Tarefa",
                        ),
                      ),
                      const SizedBox(height: 50,),
                      SizedBox(
                        height: 55,
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: const StadiumBorder()
                          ),
                          onPressed: (){
                            TaskModel newTask = TaskModel(
                              task: taskController.text,
                              dateTime: DateTime.now(),
                              day: widget.day,
                              month: widget.month,
                            );

                            helper.addTask(newTask);
                          }, 
                          child: const Text(
                            "Salvar tarefa",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      backgroundColor: Colors.orange,
      child: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}