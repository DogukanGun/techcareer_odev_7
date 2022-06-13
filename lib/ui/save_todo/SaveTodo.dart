import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techcareer_odev_7/entity/todo.dart';
import 'package:techcareer_odev_7/ui/save_todo/SaveTodoCubit.dart';


class SaveTodo extends StatefulWidget {
  const SaveTodo({Key? key}) : super(key: key);

  @override
  State<SaveTodo> createState() => _SaveTodoState();
}

class _SaveTodoState extends State<SaveTodo> {
  var tfTodoYapilacakIs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo Save"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfTodoYapilacakIs,decoration: const InputDecoration(hintText: "Kişi Adı"),),
              ElevatedButton(onPressed: (){
                context.read<SaveTodoCubit>().saveTodo(Todo(yapilacak_id: 0,yapilacak_is: tfTodoYapilacakIs.text));
              }, child: const Text("KAYDET"))
            ],
          ),
        ),
      ),
    );
  }
}
