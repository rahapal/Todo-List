import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/presentation/presentation.dart';

class CustomDateField extends StatefulWidget {
  const CustomDateField({
    super.key,
    required this.labelText,
    this.isInitialFocused,
    this.enabled = true,
    required this.hintText,
    this.firstDate,
    this.lastDate,
    this.initialValue,
    this.labelStyle,
    this.isCalenderDesign = true,
    this.isNewDesign = true,
    this.labelGap = 8,
    this.iconSize = 18,
    this.onSaved,
    this.validator,
    this.dateFormat = "MM/dd/yyyy",
  });
  final String labelText;
  final bool? isInitialFocused;
  final String dateFormat;
  final String hintText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialValue;
  final void Function(DateTime?)? onSaved;
  final bool enabled;
  final String? Function(String?)? validator;
  final bool isCalenderDesign;
  final bool isNewDesign;
  final TextStyle? labelStyle;
  final double labelGap;
  final double iconSize;

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  final TextEditingController dateController = TextEditingController();

  final OverlayPortalController _dropDownController = OverlayPortalController();

  final GlobalKey _globalKey = GlobalKey();

  Offset? currentPosition;

  getPosition() {
    _dropDownController.toggle();
    if (_globalKey.currentContext != null) {
      RenderBox renderBox =
          _globalKey.currentContext!.findRenderObject() as RenderBox;
      var newPosition = renderBox.localToGlobal(Offset.zero);
      var pageHeight = MediaQuery.of(context).size.height - kToolbarHeight;

      var checkPoint = newPosition.dy + 72 + 320;
      if (checkPoint >= pageHeight) {
        currentPosition = Offset(newPosition.dx, newPosition.dy - (320 + 72));
      } else {
        currentPosition = newPosition;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      dateController.text =
          DateFormat(widget.dateFormat).format(widget.initialValue!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCalenderDesign) {
      return OverlayPortal(
        key: _globalKey,
        controller: _dropDownController,
        overlayChildBuilder: (context) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _dropDownController.hide();
                },
                child: Container(
                  color: Colors.black26,
                ),
              ),
              Positioned(
                left: 15,
                top: (currentPosition?.dy ?? 0) + 72,
                child: Container(
                  // height: 355,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.borderGrey,
                    ),
                  ),
                  child: TableCalendar(
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    availableGestures: AvailableGestures.all,
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, day, focusedDay) {
                        return const CircleAvatar();
                      },
                      todayBuilder: (context, day, focusedDay) => CircleAvatar(
                        child: Text(day.toFormattedString("d")),
                      ),
                    ),
                    focusedDay: widget.initialValue ?? DateTime.now(),
                    currentDay: widget.initialValue,
                    firstDay: widget.firstDate ??
                        DateTime(
                          DateTime.now().year - 100,
                        ),
                    lastDay: widget.lastDate ??
                        DateTime(
                          DateTime.now().year + 100,
                        ),
                    onDaySelected: (selectedDay, focusedDay) {
                      _dropDownController.hide();
                      dateController.text =
                          DateFormat(widget.dateFormat).format(selectedDay);
                      widget.onSaved?.call(selectedDay);
                      setState(() {});
                    },
                  ),

                  // child: CalendarDatePicker(
                  //   initialDate: widget.initialValue,
                  // firstDate: widget.firstDate ??
                  //     DateTime(
                  //       DateTime.now().year - 100,
                  //     ),
                  //   lastDate: widget.lastDate ??
                  //       DateTime(
                  //         DateTime.now().year + 100,
                  //       ),
                  //   onDateChanged: (v) {
                  //     _dropDownController.hide();
                  //     dateController.text =
                  //         DateFormat(widget.dateFormat).format(v);
                  //     widget.onSaved?.call(v);
                  //     setState(() {});
                  //   },
                  //   currentDate: null,
                  //   initialCalendarMode: DatePickerMode.day,
                  // ),
                ),
              ),
            ],
          );
        },
        child: CustomTextField(
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
          enableInteractiveSelection: false,
          readOnly: true,
          controller: dateController,
          hintText: widget.hintText,
          onTap: widget.enabled ? getPosition : null,
          validator: widget.validator,
          fillColor: Colors.transparent,
          suffixIcon: const Icon(
            Icons.calendar_month,
            size: 24,
            color: AppColors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.black, width: 1),
          ),
        ),
      );
    }
    return InkWell(
      onTap: widget.enabled
          ? () {
              showDatePicker(
                context: context,
                initialDate: widget.initialValue,
                firstDate: widget.firstDate ??
                    DateTime(
                      DateTime.now().year - 100,
                    ),
                lastDate: DateTime(
                  DateTime.now().year + 100,
                ),
              ).then((value) {
                if (value != null) {
                  dateController.text =
                      DateFormat(widget.dateFormat).format(value);
                  widget.onSaved?.call(value);
                  setState(() {});
                }
              });
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.borderGrey,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.calendar_month_outlined,
                size: 18,
              ),
            ),
            Text(
              widget.labelText,
              style: widget.labelStyle?.copyWith(color: AppColors.black),
            ),
            Container(
              height: 18,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 1,
              color: AppColors.borderGrey,
            ),
            if (dateController.text.isNotEmpty)
              Expanded(
                child: Text(
                  dateController.text,
                  maxLines: 1,
                ),
              )
            else
              Expanded(
                child: Text(
                  widget.hintText,
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
