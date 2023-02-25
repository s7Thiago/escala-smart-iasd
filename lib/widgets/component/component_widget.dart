import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/component_model.dart';
import 'package:iasd_escala/pages/component/edit_component.dart';
import 'package:iasd_escala/shared/utils.dart';

class ComponentWidget extends StatefulWidget {
  const ComponentWidget({
    Key? key,
    required this.component,
  }) : super(key: key);

  final Component component;

  @override
  State<ComponentWidget> createState() => _ComponentWidgetState();
}

class _ComponentWidgetState extends State<ComponentWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCubic,
    reverseCurve: Curves.easeInOutCubic
  );

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              child: Text(widget.component.name[0]),
            ),
            const SizedBox(width: 30),
            Text(widget.component.name),
            const SizedBox(width: 180),
            IconButton(
              onPressed: () => customLauncher(
                  target: EditComponentPage(component: widget.component),
                  transitionDuration: const Duration(milliseconds: 700),
                  transitionsBuilder: (p0, animation, secondaryAnimation, p1) {
                    return ScaleTransition(
                      scale: _animation,
                      alignment: Alignment.topRight,
                      child: p1,
                    );
                  },
                  context: context),
              icon: const Icon(Icons.edit),
            )
          ],
        ),
      ),
    );
  }
}
