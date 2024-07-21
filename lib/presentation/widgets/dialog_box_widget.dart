import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_list/bloc/bloc.dart';
import 'package:todo_list/presentation/presentation.dart';

class DialogBox extends StatefulWidget {
  final AddtodoCubit addtodoCubit;
  final TextEditingController noteController;
  final bool where;
  final String? date;

  final String? id;
  const DialogBox(
      {super.key,
      required this.addtodoCubit,
      required this.noteController,
      required this.where,
      this.date,
      this.id});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  late DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.where ? _parseDate(widget.date!) : DateTime.now();
  }

  DateTime _parseDate(String dateString) {
    List<String> parts = dateString.split('/');

    int day = int.parse(parts[1]);
    int month = int.parse(parts[0]);
    int year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 4),
            child: Container(
              alignment: FractionalOffset.topRight,
              child: GestureDetector(
                child: const Icon(
                  size: 30,
                  Icons.clear,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Text(
            widget.where ? 'Edit' : 'Things to do',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomTextField(
              textEditingController: widget.noteController,
              maxLines: 4,
              hintText: "Write the task",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.black, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomDateField(
              labelText: '',
              hintText: "Pick Date",
              initialValue: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onSaved: (p0) {
                setState(() {
                  selectedDate = p0;
                });
              },
              enabled: true,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String id = randomAlpha(10);
              String? date = selectedDate?.toFormattedString();

              if (widget.where) {
                Map<String, dynamic> details = {
                  "id": widget.id,
                  "note": widget.noteController.text,
                  "date": date,
                };
                widget.addtodoCubit.updateTodo(details, widget.id!);
              } else {
                Map<String, dynamic> details = {
                  "id": id,
                  "note": widget.noteController.text,
                  "date": date
                };
                widget.addtodoCubit.addTodo(details, id);
              }
              context.pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green),
            child: Text(
              widget.where ? 'Edit' : 'Add',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
