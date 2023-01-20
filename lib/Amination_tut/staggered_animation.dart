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
          
          )),
    );
  }
}