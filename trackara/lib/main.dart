import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackara/Model/DiaryModel/diary_model.dart';
import 'package:trackara/Model/GoalModel/goal_model.dart';
import 'package:trackara/Model/HabitModel/habit_model.dart';
import 'package:trackara/Model/MemoryModel/memoryModel.dart';
import 'package:trackara/Model/QuotesModel/quotesModel.dart';
import 'package:trackara/Model/UserprofileModel/userProfile_Model.dart';
import 'package:trackara/Screens/DisplayScreen/splashScreen.dart';
import 'package:trackara/Screens/ProgressScreen/progresScreen.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/privacyAndPollicy.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/reprotScreen.dart';
import 'package:trackara/Screens/SettingsScreen/SettingsParts/ProfileSetting/termsAndCondition.dart';


const SAVE_KEY_NAME="UserLoggerdin";
Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(ModelHabitAdapter().typeId)&& !Hive.isAdapterRegistered(GoalModelAdapter().typeId)
  &&!Hive.isAdapterRegistered(DiaryModelAdapter().typeId) && !Hive.isAdapterRegistered(UserProfileModelAdapter().typeId)
  && !Hive.isAdapterRegistered(QuotesmodelAdapter().typeId)&& !Hive.isAdapterRegistered(MemoryModelAdapter().typeId)
  ){
    Hive.registerAdapter(ModelHabitAdapter());
    Hive.registerAdapter(GoalModelAdapter());
    Hive.registerAdapter(DiaryModelAdapter());
    Hive.registerAdapter(UserProfileModelAdapter());
    Hive.registerAdapter(QuotesmodelAdapter());
    Hive.registerAdapter(MemoryModelAdapter());
  }
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme:const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        )
      ),
      home: SplashScreen(),);
  }
}