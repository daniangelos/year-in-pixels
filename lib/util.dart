getAllNumberOfDaysPerMonth(int year) {
  int february = isLeapYear(year) ? 29 : 28;
  return [31, february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
}

isLeapYear(int year) {
  return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}

monthsFirstLetter(int monthIndex) {
  final monthsLetter = ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];
  return monthsLetter[monthIndex-1];
}