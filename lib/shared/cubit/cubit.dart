import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archived_task_screen.dart';
import 'package:todo_app/modules/don_task_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/new_task_screen.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() :super (AppInitialState());

 static AppCubit get(context) => BlocProvider.of(context);
  //object from class can access from any place
  late int currentidex = 0;
  late Database database;
  List<Map> task = [];
  bool isbottomSheetShown = false;
  IconData fabicon = Icons.add;

  late List<Widget> Screens = [
    const NewTaskScreen(),
    const DoneTaskScreen(),
    const ArchivedTaskScreen(),
  ];
  List<String> titles =
  [
    'New Task',
    'Done Task',
    'Archived Task'
  ];

  void changeIndex (int index){
    currentidex = index;
    emit(ChangeNavigationBarState());
  }
  void createDatabase()  {
     openDatabase('ToDo.db', version: 1,
        onCreate: (database, version) async {
          await database.execute('''
           CREATE TABLE taske(
           id INTEGER PRIMARY KEY,
           title TEXT,
           date TEXT,
           time TEXT ,
           status TEXT
           )
               ''').then((value) {
            if (kDebugMode) {
              print('database createed');
            }
          }).catchError((error) {
            if (kDebugMode) {
              print('error create database${error.toString()}');
            }
          });
        }, onOpen: (database) {
          getFromDatabase(database).then((value) {
            task = value;
            print(task);
            emit(GetFromDatabaseState());
          });
          if (kDebugMode) {
            print('database opened');
          }
        }).then((value) {
          database=value;
          emit(CreateDatabaseState());
     });
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) async {
      txn.rawInsert('''
      INSERT INTO taske (title,date,time,status)VALUES("$title","$date","$time","new")''').then((value) {
        if (kDebugMode) {
          print('$value insert successfully');
          emit(InsertDatabaseState());
          getFromDatabase(database).then((value) {
            task = value;
            print(task);
            emit(GetFromDatabaseState());
          });
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('error when insert to table ${error.toString()}');
        }
      });
    });
  }
  Future< List<Map>> getFromDatabase(database) async {

    return  await database.rawQuery('SELECT * FROM taske');
  }
  void changeBottomSheet({
  required bool  isShow ,
  required  IconData icon,



}){

    isbottomSheetShown =isShow;
    fabicon = icon;
    emit(ChangeBottomSheetState());
  }

}