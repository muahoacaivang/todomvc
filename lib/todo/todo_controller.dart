import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'todo_model.dart';

class TodoController extends GetxController {
  List<TodoModel> todoModels = [];
  TextEditingController textController = TextEditingController();
  FocusNode descFocusNode = FocusNode();
  int showType = 0;

  void add(String todoDesc){
    if(todoDesc.length > 0) {
      TodoModel todoModel = TodoModel(todoDesc);
      todoModels.insert(0, todoModel);
    }
    textController.text = '';
    descFocusNode.unfocus();

    update(["todos"]);
  }

}
