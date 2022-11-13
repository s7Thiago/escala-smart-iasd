import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/component.dart';
import 'package:iasd_escala/escala/providers/component_provider.dart';
import 'package:iasd_escala/widgets/component/component_available_day_selector_widget.dart';
import 'package:iasd_escala/widgets/ui/app_fab.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:iasd_escala/shared/utils.dart';

class NewComponentScreen extends StatelessWidget {
  final Component? component;

  const NewComponentScreen({super.key, this.component});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final componentsProvider =
        Provider.of<ComponentProvider>(context, listen: true);
    var textEditingController = TextEditingController();
    Component c = component ?? componentsProvider.aux;

    return Padding(
      padding: EdgeInsets.only(
        top: (size.height * .24).clamp(15.0, 300.0),
        bottom: (size.height * .05).clamp(50.0, 100.0),
        left: (size.width * (size.width < 1000 ? .1 : .35)).clamp(15.0, 800.0),
        right: (size.width * (size.width < 1000 ? .1 : .35)).clamp(15.0, 800.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'newComponentPage',
            child: Material(
              color: Colors.white,
              animationDuration: const Duration(milliseconds: 700),
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              type: MaterialType.card,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 500,
                width: 600,
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                          '${componentsProvider.detectMode().name == 'create'? '➕' : '💾'} ${c.name}'),
                      const Spacer(),
                      isKeyboardHidden(context)
                          ? Flexible(
                              flex: 3,
                              child: ComponentAvailableDaySelectorWidget(
                                component: c,
                              ))
                          : Material(
                            color: Colors.white,
                            elevation: 3,
                            child: InkWell(
                              splashColor: Colors.tealAccent,
                              onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // hide keyboard
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * .5,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Transform.rotate(
                                        angle: math.pi / 2,
                                        child: const Icon(Icons.arrow_back_ios,
                                            color: Colors.grey),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Choose weekdays',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                              ),
                            ),
                          ),
                      const Spacer(),
                      TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          labelText: 'Digite o nome da pessoa aqui',
                          hintText: 'Josefina...',
                        ),
                        // maxLength: 15,
                        onChanged: (componentName) {
                          c.updateName(componentName);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ================ Animated cancel button ================
              Flexible(
                flex: 1,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: -.75, end: 0.0),
                  curve: Curves.easeInOutQuart,
                  duration: const Duration(milliseconds: 1200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppFab(
                        onPressed: () {
                          componentsProvider.resetAux();
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.deepOrange,
                        icon: Icons.close,
                      ),
                    ],
                  ),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(value * 100, 0),
                      child: child,
                    );
                  },
                ),
              ),

              // ================ Animated confirm button ================
              Flexible(
                flex: 1,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: .75, end: 0.0),
                  curve: Curves.easeInOutQuart,
                  duration: const Duration(milliseconds: 1200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppFab(
                        onPressed: () {
                          componentsProvider.addOrUpdate(c);
                          componentsProvider.resetAux();
                          componentsProvider.updateListeners();
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.lightGreen,
                        icon: Icons.check,
                      ),
                    ],
                  ),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(value * 100, 0),
                      child: child,
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
