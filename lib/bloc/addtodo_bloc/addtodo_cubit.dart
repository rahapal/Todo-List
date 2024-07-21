import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/addtodo_bloc/addtodo_state.dart';
import 'package:todo_list/data/models/todo_model.dart';
import 'package:todo_list/data/repo/todo/add_todo_repo.dart';

class AddtodoCubit extends Cubit<AddtodoState> {
  final AddTodoRepo addTodoRepo;

  AddtodoCubit(this.addTodoRepo) : super(TodoLoadingState()) {
    fetchDetails();
  }

  void fetchDetails() {
    try {
      emit(TodoinitialState());
      Stream<List<TodoModel>> list = addTodoRepo.showTodo();
      list.listen((todos) {
        emit(TodoSuccessState(todos));
      });
    } catch (e) {
      emit(TodoErrorState("$e"));
    }
  }

  void deleteTodo(String id) {
    emit(TodoLoadingState());
    try {
      addTodoRepo.deleteTodo(id);
      emit(DeleteSuccessState());
    } catch (e) {
      emit(TodoErrorState("$e"));
    }
  }

  void addTodo(Map<String, dynamic> datas, String id) {
    try {
      addTodoRepo.addTodo(datas, id);
    } catch (e) {
      emit(TodoErrorState("$e"));
    }
  }

  void updateTodo(Map<String, dynamic> datas, String id) {
    emit(TodoLoadingState());
    try {
      addTodoRepo.updateTodo(datas, id);
      emit(EditSuccessState());
    } catch (e) {
      emit(TodoErrorState("$e"));
    }
  }
}
