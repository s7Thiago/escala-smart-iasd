import 'package:flutter/material.dart';

extension PowerExtensions on Widget {
  putElevatedHero({required tag}) {
    return Hero(
      tag: tag,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(3),
        child: this,
      ),
    );
  }

putOnHero({required tag}) {
    return Hero(
      tag: tag,
      child: this,
    );
  }

  putFloatingHero({
    required tag,
    required context,
    title = 'no title',
    Color titleColor = Colors.black87,
    EdgeInsetsGeometry? margin =
        const EdgeInsets.symmetric(horizontal: 30.0, vertical: 120.0),
  }) {
    return Container(
      margin: margin,
      child: Hero(
        tag: tag,
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              this,
              Positioned(
                top: 10,
                left: 20,
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onFlex({flex = 1}) => Flexible(flex: flex, child: this);

  closeable({required BuildContext context}) {
    Future.delayed(const Duration(milliseconds: 800));
    return Stack(
      children: [
        this,
        Positioned(
          right: 10,
          bottom: 10,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(15),
              splashColor: Colors.white,
              child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
