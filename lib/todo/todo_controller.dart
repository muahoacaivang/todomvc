import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_model.dart';

class TodoController extends GetxController {
  List<TodoModel> todoModels = [];
  List<TodoModel> filterModels = [];
  TextEditingController textController = TextEditingController();
  FocusNode descFocusNode = FocusNode();
  int currType = 0;
  int leftCount = 0;

  void addTodo(String todoDesc){
    if(todoDesc.length > 0) {
      TodoModel todoModel = TodoModel(todoDesc);
      todoModels.insert(0, todoModel);

      _filterTodo();
    }
    textController.text = '';
    descFocusNode.unfocus();

    update(["todos"]);
  }

  void changeShowType(int showType){
    currType = showType;

    _filterTodo();
    update(["todos"]);
  }

  void completeTodo(TodoModel todoModel,bool isDone){
    todoModel.isDone = isDone;
    _filterTodo();
    update(["todos"]);
  }

  void clearComplete(){
    todoModels =
        todoModels.where((element) => element.isDone == false).toList();
    _filterTodo();
    update(["todos"]);
  }

  void deleteTodo(TodoModel todoModel){
    todoModels.remove(todoModel);
    _filterTodo();
    update(["todos"]);
  }

  void _filterTodo() {
    if (currType == 1) {
      filterModels =
          todoModels.where((element) => element.isDone == false).toList();
      leftCount = filterModels.length;
    } else if (currType == 2) {
      filterModels =
          todoModels.where((element) => element.isDone == true).toList();
      leftCount = todoModels.length - filterModels.length;
    } else {
      leftCount = 0;
      todoModels.forEach((element) {
        if(!element.isDone)
          leftCount++;
      });
      filterModels = todoModels;
    }
  }
}
