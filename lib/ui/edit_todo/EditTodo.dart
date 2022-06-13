import 'package:flutter/material.dart';

import '../../entity/todo.dart';

class EditTodo extends StatefulWidget {
  Todo todo;

  EditTodo({required this.todo});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
