class DateAndTime {
  int year;
  int month;
  int day;
  int hour;
  int minute;

  DateAndTime(
      {required this.year,
      required this.month,
      required this.day,
      required this.hour,
      required this.minute});
}

String get TimeNow {
  DateTime now = DateTime.now();

  DateAndTime tarihSaat = DateAndTime(
    year: now.year,
    month: now.month,
    day: now.day,
    hour: now.hour,
    minute: now.minute,
  );
  return "${tarihSaat.day}-${tarihSaat.month}-${tarihSaat.year} ${tarihSaat.hour}:${tarihSaat.minute}";
}
