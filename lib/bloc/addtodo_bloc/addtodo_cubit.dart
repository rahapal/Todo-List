import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/presentation/presentation.dart';

class AddtodoCubit extends Cubit<AddtodoState> {
  final AddTodoRepo addTodoRepo;
  final CompletedTodoRepo completedTodoRepo;

  AddtodoCubit(this.addTodoRepo, this.completedTodoRepo)
      : super(TodoinitialState()) {
    fetchDetails();
  }

  void fetchDetails() {
    try {
      emit(TodoLoadingState());
      Stream<List<TodoModel>> list = addTodoRepo.showTodo();
      list.listen((todos) {
        emit(TodoSuccessState(todos));
      });
    } catch (e) {
      emit(TodoErrorState("$e"));
    }
  }

  void doneTodo(String id, Map<String, dynamic> datas) {
    emit(TodoLoadingState());
    try {
      addTodoRepo.deleteTodo(id).then((v) {
        completedTodoRepo.addCompletedTodo(datas, id);
      });

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

  void updateTodo(Map<String, dynamic> datas, String id) async {
    emit(TodoLoadingState());
    try {
      await addTodoRepo.updateTodo(datas, id);

      BotToast.showText(
          text: "You Edited your Todo", contentColor: AppColors.green);
    } catch (e) {
      emit(TodoErrorState("$e"));
    }
  }
}
