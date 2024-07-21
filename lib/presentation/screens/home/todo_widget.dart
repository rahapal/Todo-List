import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/presentation/presentation.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  final addToDoCubit = AddtodoCubit(AddTodoRepo(), CompletedTodoRepo());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => addToDoCubit,
        child: BlocConsumer<AddtodoCubit, AddtodoState>(
          listener: (context, state) {
            if (state is DeleteSuccessState) {
              BotToast.showText(
                  text: "You have completed your Todo",
                  contentColor: AppColors.green);
            }
          },
          builder: (context, state) {
            if (state is TodoLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodoErrorState) {
              return Center(child: Text(state.error));
            } else if (state is TodoSuccessState) {
              final todos = state.todos;
              if (todos.isEmpty) {
                return const Center(child: Text('No Todos to show up'));
              }

              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final model = todos[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.containerBgcolor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.fadedGreen),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Need to do",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  model.date,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "- ${model.note}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Map<String, dynamic> datas = {
                                      "id": model.id,
                                      "date": model.date,
                                      "note": model.note
                                    };

                                    context
                                        .read<AddtodoCubit>()
                                        .doneTodo(model.id, datas);
                                  },
                                  child: const Text(
                                    "Done",
                                    style: TextStyle(color: AppColors.green),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    _textEditingController.text = model.note;
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Dialog(
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          child: DialogBox(
                                            addtodoCubit: addToDoCubit,
                                            noteController:
                                                _textEditingController,
                                            where: true,
                                            date: model.date,
                                            id: model.id,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(color: AppColors.green),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox(
                height: 400.0,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.red,
                )),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: DialogBox(
                  addtodoCubit: addToDoCubit,
                  noteController: _noteController,
                  where: false,
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}
