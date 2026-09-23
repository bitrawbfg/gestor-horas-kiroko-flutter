enum WeekdaysEnum { week1, week2, week3, week4 }

extension WeekdaysEnumExtension on WeekdaysEnum {
  String get value {
    switch (this) {
      case WeekdaysEnum.week1:
        return 'Semana 1';
      case WeekdaysEnum.week2:
        return 'Semana 2';
      case WeekdaysEnum.week3:
        return 'Semana 3';
      case WeekdaysEnum.week4:
        return 'Semana 4';
      }
  }
}
