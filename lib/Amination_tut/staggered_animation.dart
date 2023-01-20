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
    return const Placeholder();
  }
}