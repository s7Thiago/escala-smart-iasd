import 'package:flutter/material.dart';

class AppFab extends StatelessWidget {
  final VoidCallback onPressed;
  final String? heroTag;
  final IconData icon;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? iconColor;

  const AppFab({
    super.key,
    required this.onPressed,
    this.heroTag,
    this.backgroundColor = Colors.white,
    this.icon = Icons.add,
    this.shadowColor = Colors.white,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return heroTag != null? Hero(
      tag: heroTag!,
      child: Material(
        shadowColor: shadowColor,
        animationDuration: const Duration(milliseconds: 700),
        elevation: 5,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {},
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              splashRadius: 25,
              icon: Icon(
                icon,
                color: iconColor,
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    ) : Material(
      animationDuration: const Duration(milliseconds: 700),
      shadowColor: shadowColor,
      elevation: 5,
      color: backgroundColor,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {},
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              icon,
              color: iconColor,
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
