import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:todogetx/controller/controll.dart';
import 'package:todogetx/view/componets/tasks.dart';

class DoneTasksScreen  extends StatelessWidget {
  final controller=Get.lazyPut(()=>AppController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(

        builder:(controller){
          var tasks= controller.doneTasks;
          return tasksBuilder(tasks: tasks!);
        }
    );
  }
}