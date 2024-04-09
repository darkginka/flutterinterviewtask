import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class Utils {
  static String formatDate(DateTime date, String format) {
    DateFormat formatter = DateFormat(format);
    return formatter.format(date);
  }

  static DateTime parseTime(String time, String formatPattern) {
    DateFormat format = DateFormat(formatPattern);
    return format.parse(time);
  }

  static String formatTimeOfDay(time) {
    DateTime now = DateTime.now();
    DateTime dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return Utils.formatDate(dateTime, 'hh:mm a');
  }

  static String timeStampToDate(String timestamp,
      {String format = 'dd-MM-yyyy hh:mm a'}) {
    DateTime createDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    String date = Utils.formatDate(createDate, format);
    return date;
  }

  static String formatTime(String time) {
    final parsedTime = DateFormat('HH:mm').parse(time);
    return DateFormat('hh:mm a').format(parsedTime);
  }

  static String previousDate(String date) {
    final parsedDate =
        DateFormat('yyyy-MM-dd').parse(date).subtract(Duration(days: 1));
    String newdate = Utils.formatDate(parsedDate, 'yyyy-MM-dd');
    return newdate;
  }

  static getMonthsList(DateTime startDate, DateTime endDate) {
    Map monthsMap = {};
    DateTime cDate = DateTime(startDate.year, startDate.month);
    while (cDate.isBefore(endDate) || cDate == endDate) {
      monthsMap[Utils.formatDate(cDate, 'MMMM yy')] =
          DateTime(cDate.year, cDate.month, 0).day.toString();
      if (cDate.month == 12) {
        cDate = DateTime(cDate.year + 1, 1);
      } else {
        cDate = DateTime(cDate.year, cDate.month + 1);
      }
    }
    return monthsMap;
  }

  static String replaceSpaceWithUnderscore(String input) {
    return input.replaceAll(' ', '_');
  }

  static double replaceSpaceWithDot(String input) {
    return double.parse(input.replaceAll(RegExp('[:]'), '.'));
  }

  static bool isTwoWeekday(DateTime date) {
    return date.weekday != DateTime.sunday && date.weekday != DateTime.saturday;
  }

  static bool isOneWeekday(DateTime date, int day) {
    return date.weekday != day;
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List daysList = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      daysList.add(Utils.formatDate(
          DateTime(startDate.year, startDate.month, startDate.day + i),
          'yyyy-MM-dd'));
    }
    return daysList;
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '$hours:$minutes';
  }


  static convertTimeToMinutes(String timeString) {
    List<String> components = timeString.split(' ');
    List<String> timeComponents = components[0].split(':');
    int hours = int.parse(timeComponents[0]);
    int minutes = int.parse(timeComponents[1]);
    if (components[1] == 'PM' && hours != 12) {
      hours += 12;
    } else if (components[1] == 'AM' && hours == 12) {
      hours = 0;
    }
    return hours * 60 + minutes;
  }


  static String generateRandomPassword() {
    const String chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    Random random = Random();
    String password = '';
    for (int i = 0; i < 8; i++) {
      int index = random.nextInt(chars.length);
      password += chars[index];
    }
    return password;
  }

  static String generateOTP() {
    const String chars = "0123456789";
    Random random = Random();
    String password = '';
    for (int i = 0; i < 6; i++) {
      int index = random.nextInt(chars.length);
      password += chars[index];
    }
    return password;
  }

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool validatePanNumber(String panNumber) {
    String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(panNumber)) {
      return true;
    }
    return false;
  }

  static bool validateEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return true;
    }
    return false;
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    double distance = 12742 * asin(sqrt(a));

    return distance;
  }

  static onlyFloatNumber() {
    final value = [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))];
    return value;
  }

  static onlyIntNumber() {
    final value = [FilteringTextInputFormatter.allow(RegExp('[0-9]'))];
    return value;
  }

  static onlyAlphaNumber() {
    final value = [FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z ]'))];
    return value;
  }

  static onlyAlpha() {
    final value = [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))];
    return value;
  }

  static assetImageToUint8List(String path) async {
    ByteData bytes = await rootBundle.load(path);
    Uint8List list = bytes.buffer.asUint8List();
    return list;
  }
}
