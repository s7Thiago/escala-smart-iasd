import '../enums/date_names.dart';

class Component {
  final String name;
  final List<WeekDayNames> availableDays;

  const Component({required this.name, required this.availableDays});

  @override
  String toString() => 'TeamComponent(name: $name)';
}
