import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/presentation/presentation.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({super.key});

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CompletedtodoCubit(CompletedTodoRepo()),
        child: BlocConsumer<CompletedtodoCubit, CompletedtodoState>(
          listener: (context, state) {
            if (state is CompletedLoadingState) {
              BotToast.showLoading();
            } else {
              BotToast.closeAllLoading();
            }
            if (state is CompletedDeleteSuccessState) {
              BotToast.showText(
                  text: "Deleted the task you have done",
                  contentColor: AppColors.green);
            }
          },
          builder: (context, state) {
            if (state is CompletedLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CompletedErrorState) {
              return Center(child: Text(state.error));
            } else if (state is CompletedSucessState) {
              final completedlist = state.completedlist;
              if (completedlist.isEmpty) {
                return const Center(
                    child: Text('You haven\'t completed any todos'));
              }

              return ListView.builder(
                itemCount: completedlist.length,
                itemBuilder: (context, index) {
                  final model = completedlist[index];
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
                                    context
                                        .read<CompletedtodoCubit>()
                                        .deleteTodo(model.id);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: AppColors.red,
                                  ),
                                ),
                                const SizedBox(width: 8),
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
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
