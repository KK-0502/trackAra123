import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trackara/Screens/ActivityScreen/activity.dart';
import 'package:trackara/Screens/ActivityScreen/Habit/habitAddValue.dart';

class HabitScreem extends StatelessWidget {
  const HabitScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today Habit",
                  style: TextStyle(fontFamily: 'Mine', fontSize: 21),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return ActivityScreen();
                      }));
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(
                          fontFamily: "Mine",
                          fontSize: 14,
                          color: Colors.orange),
                    ))
              ],
            ),
            Expanded(
              child: HabitList(),
            )
          ],
        ),
      ),
    );
  }
}
