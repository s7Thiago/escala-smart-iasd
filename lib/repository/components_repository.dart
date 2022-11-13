import 'package:hive/hive.dart';
import 'package:iasd_escala/escala/models/component.dart';

class ComponentsRepository {
  final Box<Component> componentsBox;

  const ComponentsRepository(this.componentsBox);

  List<Component> findAll() {
    return componentsBox.values.toList();
  }

  Future<bool> remove(Component component) {

    int index = componentsBox.values.toList().indexOf(component);

    if (index != -1) {
      return componentsBox.deleteAt(index).then((value) => true).onError((error, stackTrace) => false);
    }

    return Future.value(false);
    }

  void clearAll() {
    componentsBox.clear();
  }

  bool insert(Component component) {
    try {
      var l = findAll();
      componentsBox.put(component.name, component);
    } catch (e) {
      return false;
    }

    return true;
  }

  void update(Component c) {
    componentsBox.put(c.name, c);
  }

  bool updateList(List<Component> components) {
    try {
      clearAll();

      componentsBox.addAll(components);
    } catch (e) {
      return false;
    }

    return false;
  }
}
