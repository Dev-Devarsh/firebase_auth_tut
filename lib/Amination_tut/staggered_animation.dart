import 'package:flutter/material.dart';

class StaggeredAnimation extends StatefulWidget {
  const StaggeredAnimation({super.key});

  @override
  State<StaggeredAnimation> createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<StaggeredAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..repeat(reverse: false);
    // to repeat in reverse manner also set [reverse: true]
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(
        controller: _controller,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({required this.controller})
      : animation = HomePageAnimation(controller: controller);

  final AnimationController controller;
  final HomePageAnimation animation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: AnimatedBuilder(
      animation: animation.controller,
      builder: (context, child) {
        return Column(children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Container(
                  height: animation.barHeight.value,
                  width: double.infinity,
                  color: Colors.green.shade500,
                ),
                circle(size, animation.avtarSize.value),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(children: [
              SizedBox(
                height: 60,
              ),
              Opacity(
                  opacity: animation.titleOpacity.value,
                  child: customAliged(28, 150, Alignment.centerLeft)),
              SizedBox(
                height: 60,
              ),
              Opacity(
                  opacity: animation.textOpacity.value,
                  child:
                      customAliged(350, double.infinity, Alignment.bottomLeft)),
            ]),
          )
        ]);
      },
    ));
  }

  Positioned circle(Size size, double animationValue) {
    return Positioned(
        top: 200,
        left: size.width / 2 - 50,
        child: Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.diagonal3Values(animationValue, animationValue, 1.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.green.shade700),
          ),
        ));
  }

  Align customAliged(double height, double width, Alignment aligement) {
    return Align(
      alignment: aligement,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade300),
      ),
    );
  }
}

class HomePageAnimation {
  HomePageAnimation({required this.controller})
      : barHeight = Tween<double>(begin: 0, end: 250).animate(CurvedAnimation(
            parent: controller, curve: Interval(0, 0.3, curve: Curves.easeIn))),
        avtarSize = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.3, 0.6, curve: Curves.elasticOut))),
        titleOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.6, 0.65, curve: Curves.easeIn))),
        textOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.65,
              0.8,
            )));

  final AnimationController controller;
  final Animation<double> barHeight;
  final Animation<double> avtarSize;
  final Animation<double> titleOpacity;
  final Animation<double> textOpacity;
}
