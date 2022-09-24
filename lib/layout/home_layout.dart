import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/constant.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import '../shared/components/component.dart';


class HomeLayoutScreen extends StatelessWidget {
  HomeLayoutScreen({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is InsertDatabaseState){

            Navigator.pop(context);

          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentidex],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blue[900],
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                if (cubit.isbottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                   title: titleController.text,
                    time: timeController.text,
                    date: dateController.text);
                  }

                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.grey[100],
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultTextFormFelid(
                                    controller: titleController,
                                    lable: 'Title',
                                    type: TextInputType.text,
                                    perfix: Icons.title,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                defaultTextFormFelid(
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2023-12-30'))
                                          .then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    controller: dateController,
                                    lable: 'Date',
                                    type: TextInputType.datetime,
                                    perfix: Icons.date_range,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'date must not be empty';
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                defaultTextFormFelid(
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                        print(value.format(context));
                                      });
                                    },
                                    controller: timeController,
                                    lable: 'Time',
                                    type: TextInputType.datetime,
                                    perfix: Icons.watch_later_outlined,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'time must not be empty';
                                      }
                                      return null;
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ).closed
                      .then((value) {

                    cubit.changeBottomSheet(isShow: false, icon: Icons.add);




                  });

                  cubit.changeBottomSheet(isShow:true, icon:Icons.edit);
                  titleController.text = dateController.text =timeController.text = "";
                }
              },
              child: Icon(cubit.fabicon),
            ),
            body: cubit.Screens[cubit.currentidex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentidex,
              onTap: (index) {
                cubit.changeIndex(index);

                if (kDebugMode) {
                  print(index);
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud_done_rounded),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
