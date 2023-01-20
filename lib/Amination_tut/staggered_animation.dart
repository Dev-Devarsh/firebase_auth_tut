import 'package:flutter/material.dart';

class FlowWidgetTut extends StatefulWidget {
  const FlowWidgetTut({super.key});

  @override
  State<FlowWidgetTut> createState() => _FlowWidgetTutState();
}

class _FlowWidgetTutState extends State<FlowWidgetTut>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}