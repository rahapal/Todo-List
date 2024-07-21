import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/data/data.dart';

class CompletedtodoCubit extends Cubit<CompletedtodoState> {
  final CompletedTodoRepo completedTodoRepo;

  CompletedtodoCubit(this.completedTodoRepo) : super(CompletedLoadingState()) {
    fetchDetails();
  }

  void fetchDetails() {
    try {
      emit(CompletedInitialState());
      Stream<List<TodoModel>> list = completedTodoRepo.showTodo();
      list.listen((completedlist) {
        emit(CompletedSucessState(completedlist));
      });
    } catch (e) {
      emit(CompletedErrorState("$e"));
    }
  }

  void deleteTodo(String id) {
    emit(CompletedLoadingState());
    try {
      completedTodoRepo.deleteTodo(id);
      emit(CompletedDeleteSuccessState());
    } catch (e) {
      emit(CompletedErrorState("$e"));
    }
  }
}
