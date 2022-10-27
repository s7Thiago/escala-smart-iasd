import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/models/component.dart';
import 'package:iasd_escala/shared/extensions.dart';

class EditComponentPage extends StatelessWidget {
  final Component component;

  const EditComponentPage({Key? key, required this.component})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text('Edit component'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_rounded),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: component.availableDays.length,
          itemBuilder: (context, index) {
            List<WeekDayNames> availableDays = component.availableDays;

            if (availableDays.isNotEmpty) {
              return ListTile(
                title: Text(component.availableDays[index].ptBrString),
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.delete)),
              );
            }

            return const Text('No days available');
          },
        ),
      ).closeable(context: context),
    ).putFloating(
      context: context,
      title: 'Editar informações de ${component.name}',
      titleColor: Colors.white,
      margin: const EdgeInsets.only(
        top: 300,
        bottom: 35,
        left: 20,
        right: 70,
      ),
    );
  }
}
