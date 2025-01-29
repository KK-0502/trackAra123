import 'package:flutter/material.dart';
import 'package:trackara/Functions/db_doal.dart';
import 'package:trackara/Model/GoalModel/goal_model.dart';
import 'package:trackara/Screens/ActivityScreen/Goal/viewGoal.dart';
import 'package:trackara/Screens/ActivityScreen/Goal/viewGoalNew.dart';

class ListGoal extends StatefulWidget {
  const ListGoal({super.key});

  @override
  State<ListGoal> createState() => _ListGoalState();
}

class _ListGoalState extends State<ListGoal> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: goalModelNotify,  // Listens to the changes in goalModelNotify
      builder: (BuildContext ctx, List<GoalModel> goalModelList, Widget? child) {
        if(goalModelList.isEmpty){
          return Center(
            child: Text("No Goal Found Add Goal"),
          );
        }
        return ListView.separated(
          itemBuilder: (ctx, index) {
            GoalModel goal = goalModelList[index];

            // Calculate progress as a percentage of goal completion
            double progress = 0.0;
            if (goal.amount > 0) {
              progress = goal.addValue! / goal.amount;  // Calculate the progress ratio
            }

            return GestureDetector(
              onTap: () {
                // Navigate to the ViweGoal screen on tap
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ViewGoalScreen(
                      goal: goalModelList[index],
                      index: index,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal.name,
                    style: TextStyle(fontFamily: 'Mine', fontSize: 16),
                  ),
                  LinearProgressIndicator(
                    value: progress,  // Set the progress dynamically
                    color: Color(0xFF00F7FF),
                    minHeight: 13,
                    backgroundColor: Color(0xFFE7E7E7),
                  ),
                  Text(
                    goal.amount.toString(),
                    style: TextStyle(
                      fontFamily: "Mine",
                      fontSize: 14,
                      color: Color(0xFF2F2F2F),
                    ),
                  ),
                  Text(
                    goal.endDate,
                    style: TextStyle(
                      fontFamily: "Mine",
                      fontSize: 14,
                      color: Color(0xFF4000FF),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(
              height: 25,  // Space between list items
            );
          },
          itemCount: goalModelList.length,
        );
      },
    );
  }
}
