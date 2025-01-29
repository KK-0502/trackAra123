import 'package:flutter/material.dart';

class DiaryViewAll extends StatelessWidget {
  const DiaryViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 75,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Diary",
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
                  ],
                ),
              ),
            ) ;
  }
}