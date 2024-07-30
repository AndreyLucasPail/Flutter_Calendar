import 'package:flutter/material.dart';
import 'package:flutter_calendar/maneger/task_maneger.dart';
import 'package:flutter_calendar/model/task_model.dart';
import 'package:flutter_calendar/utils/colors/custom_colors.dart';
import 'package:flutter_calendar/ui/task/task_screen.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    this.allTasksList,
  });

  final List<TaskModel>? allTasksList;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime currentDate = DateTime.now();
  DateTime currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(
      currentDate.year,
      currentDate.month + 1,
      0,
    ).day;
    int weekdayOfFirstDay = DateTime(
      currentDate.year,
      currentDate.month,
      1,
    ).weekday;
    int currentMonthIndex = currentDate.month;

    List<int> listDays = List<int>.generate(
      daysInMonth,
      (int index) => index + 1,
    );

    List<int> daysOfPrevMonth = List<int>.generate(
      (weekdayOfFirstDay - 1 + 7) % 7,
      (index) =>
          DateTime(currentDate.year, currentDate.month, 0).day -
          (weekdayOfFirstDay - 1) +
          index,
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

    List<String> weekDay = [
      "Seg",
      "Ter",
      "Qua",
      "Qui",
      "Sex",
      "Sab",
      "Dom",
    ];

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
                    currentDate = DateTime(
                      currentDate.year,
                      currentDate.month - 1,
                      currentDate.day,
                    );
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: CustomColors.white,
                ),
              ),
              Row(
                children: List.generate(
                  months.length,
                  (index) => Text(
                    currentMonthIndex == index ? months[index] : "",
                    style: const TextStyle(
                      color: CustomColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentDate = DateTime(
                      currentDate.year,
                      currentDate.month + 1,
                      currentDate.day,
                    );
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: CustomColors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              weekDay.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  weekDay[index],
                  style: const TextStyle(
                    color: CustomColors.white,
                    fontSize: 20,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 0.85,
              ),
              itemCount: 35,
              itemBuilder: (context, index) {
                if (index < daysOfPrevMonth.length) {
                  return Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColors.backgroundColor,
                    ),
                    child: Center(
                      child: Text(
                        "${daysOfPrevMonth[index]}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: CustomColors.white,
                        ),
                      ),
                    ),
                  );
                } else if (index < daysOfPrevMonth.length + listDays.length) {
                  int day = listDays[index - daysOfPrevMonth.length];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TaskScreen(
                            day: day,
                            month: currentDate.month,
                          ),
                        ),
                      );
                    },
                    child: Consumer<TaskManager>(
                      builder: (_, task, __) {
                        bool hasTask = widget.allTasksList!.any((task) =>
                            task.day == day && task.month == currentDate.month);

                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(3),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: currentDate.day == day &&
                                        currentDate.month == currentMonth.month
                                    ? CustomColors.orange
                                    : Colors.black45,
                              ),
                              child: Center(
                                child: Text(
                                  "$day",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: CustomColors.white,
                                  ),
                                ),
                              ),
                            ),
                            hasTask
                                ? buildCircle(CustomColors.orange)
                                : buildCircle(CustomColors.backgroundColor),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  int day = daysOfNextMonth[
                      index - daysOfPrevMonth.length - listDays.length];
                  return Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColors.backgroundColor,
                    ),
                    child: Center(
                      child: Text(
                        "$day",
                        style: const TextStyle(
                          fontSize: 20,
                          color: CustomColors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircle(Color color) {
    return Container(
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
