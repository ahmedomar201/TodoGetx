import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todogetx/controller/controll.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget
{
  final controller=Get.put(AppController());
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<AppController>(
      init: controller..createDatabase(),
      // create:(context)=>AppCubit()..createDatabase(),

        // listener:(context,state)
        // {
        //   if(state is AppInsertDatabaseState){
        //     Navigator.pop(context);
        //   }
        // },
        builder: (controller)
        {

          // AppCubit cubit = AppCubit.get(context);
         return Scaffold(
            key:scaffoldKey,
            appBar: AppBar(
              title: Text(
                  controller.titles[controller.currentIndex]),
            ),
            body: BuildCondition(
              condition:controller.initialized,
              builder:(context)=>controller.screens[controller.currentIndex] ,
              fallback:(context)=>Center(child: CircularProgressIndicator()) ,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(controller.isBottomShowDown!){
                  if(formKey.currentState!.validate()){
                    controller.insertDatabase(
                        title:titleController.text,
                        time: timeController.text,
                        date: dateController.text);

                    // insertDatabase(
                    //   date:dateController.text ,
                    //   time:timeController.text ,
                    //   title:titleController.text,
                    // ).then((value)
                    // {
                    //   getDataFromDatabase(database).then((value)
                    //   {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   isBottomShowDown=false;
                    //     //   fabIcon=Icons.edit;
                    //     //   tasks=value;
                    //     //   print(tasks);
                    //     // });
                    //   });
                    //
                    // });
                  }
                }
                else{
                  scaffoldKey.currentState!.showBottomSheet((context) =>
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          color: Colors.white,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  keyboardType:TextInputType.text,
                                  validator: (String? value) {
                                    if(value!.isEmpty){
                                      return 'title cannot be empty';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Task Title',
                                    prefixIcon: Icon(
                                        Icons.title
                                    ),
                                  ),

                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller:timeController,
                                  keyboardType:TextInputType.datetime,
                                  validator: (String? value) {
                                    if(value!.isEmpty){
                                      return 'time must be empty';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Task time',
                                    prefixIcon: Icon(
                                        Icons.watch_later_outlined
                                    ),
                                  ),
                                  onTap:(){
                                    showTimePicker(context: context,
                                      initialTime:TimeOfDay.now(),
                                    ).then((value)
                                    {
                                     timeController.text=value!.format(context).toString();
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  keyboardType:TextInputType.datetime,
                                  validator: (String? value) {
                                    if(value!.isEmpty){
                                      return 'date must be empty';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Task date',
                                    prefixIcon: Icon(
                                        Icons.calendar_today
                                    ),
                                  ),
                                  onTap:(){
                                    showDatePicker(
                                        context: context,
                                        initialDate:DateTime.now(),
                                        firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('3022-08-07'),
                                    ).then((value)
                                    {
                                      dateController.text=DateFormat.yMMMEd().format(value!);
                                    });
                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                      )
                  ).closed.then((value)
                  {
                    controller.changeBottomSheetState(isShow:false ,icon:Icons.edit );
                  });
                  controller.changeBottomSheetState(isShow:true ,icon:Icons.add );
                }
              },
              child:Icon(
                  controller.fabIcon) ,
            ),
            bottomNavigationBar:BottomNavigationBar(
              type:BottomNavigationBarType.fixed,
              currentIndex: controller.currentIndex,
              onTap: (index){
                controller.changeIndex(index);
                // setState(() {
                //   currentIndex=index;
                // });
              },
              items:controller.bottomItems!,
            ) ,
          );

        } ,

      );

  }
  //Future<String> getName()async {
  // return "ahmed omar";
  // }

  }



