import 'package:intl/intl.dart';

class DateController {
  static String stringTimeController(String val) {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(val);
    return DateFormat.Hm().format(dateTime);
  }

  static String stringDateController(String val) {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(val);
    DateTime currentDate = DateTime.now();

    String displayText;
    if (dateTime.year == currentDate.year &&
        dateTime.month == currentDate.month &&
        dateTime.day == currentDate.day) {
      displayText = 'Today';
    } else {
      DateTime tomorrowDate = currentDate.add(const Duration(days: 1));
      if (dateTime.year == tomorrowDate.year &&
          dateTime.month == tomorrowDate.month &&
          dateTime.day == tomorrowDate.day) {
        displayText = 'Tomorrow';
      } else {
        displayText = DateFormat('E').format(dateTime);
      }
    }
    return displayText;
  }
}
