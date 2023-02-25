import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/component_model.dart';
import 'package:iasd_escala/escala/providers/component_provider.dart';
import 'package:iasd_escala/pages/component/add_or_edit_component.dart';
import 'package:iasd_escala/shared/utils.dart';
import 'package:iasd_escala/widgets/ui/app_fab.dart';
import 'package:provider/provider.dart';

class ComponentListPage extends StatefulWidget {
  const ComponentListPage({super.key});

  @override
  State<ComponentListPage> createState() => ComponentListPageState();
}

class ComponentListPageState extends State<ComponentListPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
      reverseCurve: Curves.easeInOutCubic);

  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final componentsProvider =
        Provider.of<ComponentProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage components'),
      ),
      body: componentsProvider.components.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.data_array_rounded, color: Colors.grey, size: 50),
                  Text('No data to show here')
                ],
              ),
            )
          : ListView.builder(
              itemCount: componentsProvider.components.length,
              itemBuilder: (context, index) {
                Component c = componentsProvider.components[index];
                return InkWell(
                  onTap: () => customLauncher(
                      // target: EditComponentPage(component: c),
                      target: NewComponentScreen(component: c),
                      transitionDuration: const Duration(milliseconds: 700),
                      transitionsBuilder:
                          (p0, animation, secondaryAnimation, p1) {
                        return ScaleTransition(
                          scale: _animation,
                          alignment: Alignment.topRight,
                          child: p1,
                        );
                      },
                      context: context),
                  child: ListTile(
                    // leading: const Icon(Icons.person),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (c.availableDays.isNotEmpty)
                          ...List.generate(
                            c.availableDays.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  if(index > 0)
                                Container(width: 1, height: 16, color: Colors.black26),
                                const SizedBox(width: 3),
                                  Material(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.only(left: 5, bottom: 2, top: 2),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Text(
                                          c.availableDays[index].ptBrString
                                              .toUpperCase()
                                              .substring(0, 3),
                                              style: const TextStyle(
                                                color: Colors.black26,
                                                fontSize: 10
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                    title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: IconButton(
                      onPressed: () {
                        componentsProvider.remove(c);
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: AppFab(
        heroTag: 'newComponentPage',
        onPressed: () {
          customLauncher(
              target: const NewComponentScreen(),
              context: context,
              barrierDismissible: true);
        },
        iconColor: Colors.green,
        backgroundColor: Colors.greenAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
