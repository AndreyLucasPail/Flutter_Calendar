import 'package:flutter/material.dart';
import 'package:flutter_calendar/task/screen/task_screen.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key,});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  DateTime currentDate = DateTime.now();  

  @override
  Widget build(BuildContext context) {

    List<int> listDays = List<int>.generate(
      DateTime(currentDate.year, currentDate.month + 1 , 0).day, 
      (int index) => index + 1, 
    );

    print("Lista de Dias: $listDays");

    List<int> daysOfPrevMonth = List<int>.generate(
      DateTime(currentDate.year, currentDate.month, 0).weekday, 
      (index) => DateTime(currentDate.year, currentDate.month, 0).day - index,
    ).reversed.toList();

    print("Mes anterior: $daysOfPrevMonth");

    List<int> daysOfNextMonth = List<int>.generate(
      7 - (listDays.length + daysOfPrevMonth.length) % 7 , 
      (int index) => index + 1,
    );

    print("Proximo mes: $daysOfNextMonth");

    List<String> months = [
      '',
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    List<String> weekDay = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sab", "Dom"];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    currentDate = DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
                  });
                }, 
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)
              ),
              Row(
                children: List.generate(
                  months.length,
                  (index) => Text(
                    currentDate.month == index ? months[index] : "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentDate = DateTime(currentDate.year, currentDate.month + 1, currentDate.day);
                  });
                }, 
                icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              weekDay.length, 
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  weekDay[index],
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ), 
              itemCount: daysOfPrevMonth.length + listDays.length + daysOfNextMonth.length,
              itemBuilder: (context, index){

                List<int> combinedList = [...daysOfPrevMonth, ...listDays, ...daysOfNextMonth];
                int day = combinedList[index];

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const TaskScreen())
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: (daysOfPrevMonth.contains(day) && daysOfNextMonth.contains(day)) 
                      ? Colors.black 
                      : Colors.grey[900],
                    ),
                    child: Center(
                      child: Text(
                        "$day",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }  
}