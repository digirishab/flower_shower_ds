import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FlowerPage(),
    );
  }
}

class FlowerPage extends StatefulWidget {
  const FlowerPage({super.key});

  @override
  State<FlowerPage> createState() => _FlowerPageState();
}

class _FlowerPageState extends State<FlowerPage>
    with SingleTickerProviderStateMixin {

  late AnimationController _flowerController;
  late Animation<num> _flowerAnimation;

  final flowersList = List.generate(10, (index) => 'assets/images/flower_sample.jpg');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _flowerController = AnimationController(vsync: this, duration: const Duration(seconds: 10))
        ..repeat(reverse: true);
      _flowerAnimation = Tween(begin: 0, end: MediaQuery.sizeOf(context).height).animate(_flowerController);

      _flowerController.forward();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Image.asset(
            'assets/images/sample_mandir.jpg',
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height,
          ),
          AnimatedBuilder(
            animation: _flowerAnimation,
            builder: (BuildContext context, Widget? child) {
              return Positioned(
                left: 2,
                right: 2,
                top: _flowerAnimation.value as double,
                child: child!
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: flowersList.map((e) =>
                Image.asset(
                  e,
                  width: 40,
                  height: 40,
                )
              ).toList()
            )
          ),
        ],
      ),
    );
  }
}

/*
  Further Plan for the flower shower animation:

  So right now, we’ve got a single row of flowers floating down the screen as a start while I was on screen share.
  To make it look more natural and less like a single row of flowers,

  Here’s what I’m thinking:

  - Instead of moving one whole row together, we would animate each flower individually in stack.
    That way, we can make each one fall at its own speed and from a different position. How the actual shower works.

  - We can a create a class to represent a flower — probably would contain like path of image, X position(while falling down), fall speed, and its own animation controller.

  - We have to randomize the X position and fall speed (probably), we’ll avoid the uniform look and get something natural.

  - I’m planning to use a Stack to position each flower independently and layer them over the background.
    Each flower will use its own AnimatedBuilder, so they can all animate on their own timelines.

  - Disposing is also necessary of each flower.

  - Recycling flower objects once they’ve finished falling could help in performance optimisation.

  - Lastly, if we need a full blown real feeling effect of flower shower, CustomPainter would be the last resort.

  As of now, the above done code is just the base that I came up with while on the fly but this can be improved way more with the above points.
*/
