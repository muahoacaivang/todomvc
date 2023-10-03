import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'todo_controller.dart';

class TodoPage extends StatelessWidget {
  TodoPage({Key? key}) : super(key: key);
  final controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
        id: "todos",
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text('todos'),
              centerTitle: true,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'What needs to be done?',
                    ),
                    controller: controller.textController,
                    focusNode: controller.descFocusNode,
                    textInputAction:TextInputAction.next,
                    onSubmitted: (string){
                      controller.addTodo(string);
                    },
                  ),
                ),
                Expanded(
                    child: controller.filterModels.length>0?SlidableAutoCloseBehavior(
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 1,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Slidable(
                                  key: ValueKey("$index"),
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          Slidable.of(context)!.close();
                                          controller.deleteTodo(controller.filterModels[index]);
                                        },

                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),

                                    ],
                                  ),
                                  child:Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: controller.filterModels[index].isDone,
                                            onChanged: (value){
                                              controller.completeTodo(controller.filterModels[index],value!);
                                            },
                                            activeColor: Colors.grey,
                                          ),

                                          Text(controller.filterModels[index].todoDesc,
                                            style: TextStyle(
                                                decoration: controller.filterModels[index].isDone?TextDecoration.lineThrough:null,
                                                color: controller.filterModels[index].isDone?Colors.grey:Colors.black
                                            ),
                                          ),
                                        ],
                                      )
                                  )
                              );
                            },
                            itemCount:controller.filterModels.length
                        )
                    ):Center(child: Text('nothing',style: TextStyle(color: Colors.grey),),)
                ),
                SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Radio(
                              value: 0,
                              groupValue: controller.currType,
                              onChanged: (value) {
                                controller.changeShowType(value!);
                              },
                            ),
                            Text("All"),
                            SizedBox(width: 20),

                            Radio(
                              value: 1,
                              groupValue: controller.currType,
                              onChanged: (value) {
                                controller.changeShowType(value!);
                              },
                            ),
                            Text("Active"),
                            SizedBox(width: 20),

                            Radio(
                              value: 2,
                              groupValue: controller.currType,
                              onChanged: (value) {
                                controller.changeShowType(value!);
                              },
                            ),
                            Text("Completed"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(controller.leftCount.toString() + ' items left'),
                            TextButton(
                                onPressed: (){
                                  controller.clearComplete();
                                },
                                child: Text('Clear completed')
                            )
                          ],
                        )
                      ],
                    )
                ),

              ],
            )

          );
        }
    );
  }
}
