import 'package:todo_list/data/data.dart';

abstract class CompletedtodoState {}

class CompletedInitialState extends CompletedtodoState {}

class CompletedLoadingState extends CompletedtodoState {}

class CompletedSucessState extends CompletedtodoState {
  final List<TodoModel> completedlist;

  CompletedSucessState(this.completedlist);
}

class CompletedDeleteSuccessState extends CompletedtodoState {}

class CompletedErrorState extends CompletedtodoState {
  final String error;

  CompletedErrorState(this.error);
}
