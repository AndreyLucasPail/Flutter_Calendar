import 'package:flutter/material.dart';
import 'package:flutter_calendar/task/screen/task_screen.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key,});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  DateTime currentDate = DateTime.now();
  DateTime currentMonth = DateTime.now();   

  @override
  Widget build(BuildContext context) {

    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    int weekdayOfFirstDay = DateTime(currentDate.year, currentDate.month, 1).weekday;
    int currentMonthIndex = currentDate.month;

    List<int> listDays = List<int>.generate(
      daysInMonth, 
      (int index) => index + 1, 
    );

    List<int> daysOfPrevMonth = List<int>.generate(
      (weekdayOfFirstDay - 1 + 7) % 7, 
      (index) => DateTime(currentDate.year, currentDate.month, 0).day - (weekdayOfFirstDay - 1) + index,
    ).reversed.toList();

    List<int> daysOfNextMonth = List<int>.generate(
      (7 - (daysOfPrevMonth.length + listDays.length) % 7) % 7, 
      (int index) => index + 1,
    );

    daysOfPrevMonth.removeWhere((day) => day <= 0);

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

    List<String> weekDay = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sab", "Dom",];

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
                    currentMonthIndex == index ? months[index] : "",
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
              itemCount: 35,
              itemBuilder: (context, index){  
                if(index < daysOfPrevMonth.length){
                  return Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        "${daysOfPrevMonth[index]}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }else if(index < daysOfPrevMonth.length + listDays.length){
      
                  int day = listDays[index - daysOfPrevMonth.length];
      
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TaskScreen(day: day, month: currentDate.month,))
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: currentDate.day == day && currentDate.month == currentMonth.month 
                          ? Colors.orange 
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
                }else{
                  int day = daysOfNextMonth[index - daysOfPrevMonth.length - listDays.length];
                  return Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        "$day",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }         
              }
            ),
          ),
        ],
      ),
    );
  }  
}