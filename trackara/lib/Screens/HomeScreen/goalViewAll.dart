import 'package:flutter/material.dart';
import 'package:trackara/Screens/ActivityScreen/Goal/goalAddValue.dart';

class GoalViewAll extends StatelessWidget {
  const GoalViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Goals",
                          style: TextStyle(fontFamily: 'Mine', fontSize: 21),
                        ),
                        TextButton(
                            onPressed: () {},
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
                      child: ListGoal(),
                    )
                  ],
                ),
              ),
            );
  }
}