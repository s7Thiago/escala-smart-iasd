import 'package:flutter/cupertino.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/models/component_model.dart';
import 'package:iasd_escala/repository/components_repository.dart';

class ComponentProvider extends ChangeNotifier {
  final ComponentsRepository repository;
  List<Component> _components = [];
  Component aux = Component(name: '', availableDays: []);

  ComponentProvider({required this.repository}) {
    Future.delayed(const Duration(seconds: 2), () {
      // _components = repository.findAll();

      debugPrint('PROVIDER COMPONENTS ${repository.findAll()}');
      notifyListeners();
    });
    _components = repository.findAll();
    String a = '';
  }

  List<Component> get components => _components;

  remove(Component c) {
    _components.removeWhere((e) => c.name == e.name);

    repository.remove(c);

    notifyListeners();
  }

  ComponentManagerMode detectMode() {
    if (components.any((c) => aux.name.toLowerCase() == c.name.toLowerCase())) {
      return ComponentManagerMode.edit;
    }

    return ComponentManagerMode.create;
  }

  Component findByIndex(int index) => _components.elementAt(index);
  Component findByName(String name) =>
      _components.firstWhere((e) => e.name.toLowerCase() == name.toLowerCase(),
          orElse: () => Component(name: 'invalid'));

  addOrUpdate(Component newData) {
    // Search the component index
    int index = _components.indexOf(findByName(newData.name));

    if (index != -1) {
      Component aux = _components.elementAt(index);

      repository.remove(aux).then((value) {
        if (value) {
          _components[index] = newData;
          repository.insert(newData);
          notifyListeners();
          return;
        }
      });
    } else {
      if (newData.name.isNotEmpty) {
        _components.add(newData);
        repository.insert(newData);
        notifyListeners();
      }
    }
  }

  void updateListeners() {
    notifyListeners();
  }

  void resetAux() {
    aux = Component(name: '', availableDays: []);
    notifyListeners();
  }

  int getIndex(Component c) => _components.indexOf(c);

  toggleComponentDay(
      {required Component component, required WeekDayNames weekDayName}) {
    if (component.availableDays.contains(weekDayName)) {
      component.availableDays.remove(weekDayName);
    } else {
      component.availableDays.add(weekDayName);
    }
    notifyListeners();
  }
}

enum ComponentManagerMode { edit, create }
