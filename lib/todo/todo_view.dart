import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      controller.add(string);
                    },
                  ),
                ),
                Expanded(
                    child: controller.todoModels.length>0?ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 1,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Text(controller.todoModels[index].todoDesc),
                          );
                        },
                        itemCount:controller.todoModels.length
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
                              groupValue: controller.showType,
                              onChanged: (value) {

                              },
                            ),
                            Text("All"),
                            SizedBox(width: 20),

                            Radio(
                              value: 1,
                              groupValue: controller.showType,
                              onChanged: (value) {

                              },
                            ),
                            Text("Active"),
                            SizedBox(width: 20),

                            Radio(
                              value: 2,
                              groupValue: controller.showType,
                              onChanged: (value) {

                              },
                            ),
                            Text("Completed"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('items left'),
                            TextButton(
                                onPressed: (){

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
