import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key,});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  DateTime currentDate = DateTime.now();  

  @override
  Widget build(BuildContext context) {

    List<int> listdays = List<int>.generate(
      DateTime(currentDate.year, currentDate.month + 1 , 0).day, 
      (int index) => index + 1, 
    );

    List<int> daysOfPrevMonth = List<int>.generate(
      DateTime(currentDate.year, currentDate.month, 0).weekday, 
      (index) => DateTime(currentDate.year, currentDate.month, 0).day - index,
    ).reversed.toList();

    List<int> daysOfNextMonth = List<int>.generate(
      7 - (listdays.length + daysOfPrevMonth.length) % 7 , 
      (int index) => index + 1,
    );

    List<String> weekDay = ["Dom", "Ter", "Qua", "Qui", "Sex", "Sab", "Seg"];

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
              Text(
                "${currentDate.month}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
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
              (index) => Text(
                weekDay[index],
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 20
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7
              ), 
              itemCount: daysOfPrevMonth.length + listdays.length + daysOfNextMonth.length,
              itemBuilder: (context, index){

                List<int> combinedList = [...daysOfPrevMonth, ...listdays, ...daysOfNextMonth];
                int day = combinedList[index];

                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: (day <= daysOfPrevMonth.last || day > (daysOfPrevMonth.length + listdays.length)) 
                      ? Colors.grey[900] 
                      : Colors.black
                    ),
                    child: Center(
                      child: Text(
                        "$day",
                        style: TextStyle(
                          fontSize: 20,
                          color: (day <= daysOfPrevMonth.last || day > (daysOfPrevMonth.length + listdays.length)) 
                          ? Colors.grey 
                          : Colors.white,
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