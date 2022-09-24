import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../shared/components/component.dart';
import '../shared/components/constant.dart';
class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(

      listener: (context,state){},
      builder: (context,state){
        var  task = AppCubit.get(context).task;
        return  ListView.separated(
            itemBuilder: (context,index)=> buildItemTask(task[index]),
            separatorBuilder: (context,index)=> const Divider(height: 10.0,),
            itemCount:task.length);
      },

    );
  }
}
