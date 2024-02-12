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
      DateTime(currentDate.year, currentDate.month + 1 , 0).day, (int index) => index + 1, 
    );

    return Column(
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
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7
            ), 
            itemCount: listdays.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "${listdays[index]}",
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}