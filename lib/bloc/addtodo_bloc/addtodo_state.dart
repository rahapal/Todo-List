import 'package:todo_list/data/models/todo_model.dart';

abstract class AddtodoState {}

class TodoinitialState extends AddtodoState {}

class TodoLoadingState extends AddtodoState {}

class TodoSuccessState extends AddtodoState {
  final List<TodoModel> todos;

  TodoSuccessState(this.todos);
}

class EditSuccessState extends AddtodoState {}

class DeleteSuccessState extends AddtodoState {}

class TodoErrorState extends AddtodoState {
  final String error;

  TodoErrorState(this.error);
}
