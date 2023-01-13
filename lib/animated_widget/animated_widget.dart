import 'dart:developer';

import 'package:flutter/material.dart';


class AnimatedTutorial extends StatelessWidget {
  const AnimatedTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedWIdget1();
  }
}

class AnimatedWIdget1 extends StatefulWidget {
  const AnimatedWIdget1({super.key});

  @override
  State<AnimatedWIdget1> createState() => _AnimatedWIdget1State();
}

class _AnimatedWIdget1State extends State<AnimatedWIdget1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool flag = true;

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
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Switcher')),
      body: Center(
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 800),
            child: flag
                ? Container(
                    // always use [key] for Animated switcher otherwise animation will not work
                    key: Key('1'),
                    color: Colors.orange,
                    width: 200,
                    height: 200,
                  )
                : Container(
                    key: Key('2'),
                    color: Colors.blue,
                    width: 200,
                    height: 200,
                  )),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            flag = !flag;
            setState(() {});
          }),
    );
  }
}
