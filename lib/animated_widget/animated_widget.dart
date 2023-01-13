import 'package:flutter/material.dart';

class AnimatedTutorial extends StatefulWidget {
  const AnimatedTutorial({super.key});

  @override
  State<AnimatedTutorial> createState() => _AnimatedTutorialState();
}

class _AnimatedTutorialState extends State<AnimatedTutorial>
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