import 'package:intl/intl.dart';

extension DateManipulate on DateTime {
  String toFormattedString([
    String newPattern = "MM/dd/yyyy",
  ]) {
    return DateFormat(newPattern).format(this);
  }
}
