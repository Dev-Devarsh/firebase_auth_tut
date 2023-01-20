import 'dart:developer';
import 'package:flutter/material.dart';

class FlowWidgetTut extends StatefulWidget {
  const FlowWidgetTut({super.key});

  @override
  State<FlowWidgetTut> createState() => _FlowWidgetTutState();
}

double butonSize = 90;

class _FlowWidgetTutState extends State<FlowWidgetTut>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // safe area is neccessory when phone have notches , punch hole camera etc...
      // Basically it adds padding according to different screen size to avoid OS default constraines
      body: SafeArea(
          top: true,
          bottom: true,
          left: false,
          right: false,
          child: Flow(
            delegate: CustomFlowDelegate(controller: _animationController),
            children: [
              FloatingActionButton(
                  onPressed: () {
                    log('_anima ${_animationController.status}');
                    if (_animationController.status ==
                        AnimationStatus.dismissed) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                    setState(() {});
                  },
                  child: Icon(Icons.add)),
              FloatingActionButton(onPressed: () {}, child: Icon(Icons.abc)),
              FloatingActionButton(
                  onPressed: () {}, child: Icon(Icons.ac_unit)),
              FloatingActionButton(
                  onPressed: () {}, child: Icon(Icons.access_alarm_outlined)),
            ],
          )),
    );
  }
}

class CustomFlowDelegate extends FlowDelegate {
   Animation<double> controller;
  CustomFlowDelegate({
    required this.controller,
  }) : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    // context.paintChild(0, transform: Matrix4.translationValues(310, 750, 0));
    // context.paintChild(1, transform: Matrix4.translationValues(310, 680, 0));
    // context.paintChild(2, transform: Matrix4.translationValues(310, 610, 0));
    final size = context.size;
    final xStart = size.width - butonSize;
    final yStart = size.height - butonSize;
    for (var i = context.childCount - 1; i >= 0; i--) {
      final childSize = context.getChildSize(i)!.width;
      final dx = (childSize + 15) * i;
      final x = xStart; // to make flow y direction substract [-dx]
      final y = yStart -
          dx *
              controller
                  .value; // to make flow x direction substract [-dx] , which is already done
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(CustomFlowDelegate oldDelegate) {
    return controller != oldDelegate.controller;
  }
}