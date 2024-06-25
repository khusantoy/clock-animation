import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> secBrushAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));

    secBrushAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF282D41),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Analog Clock",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedBuilder(
            animation: secBrushAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(300, 300),
                painter: MyPainter(secBrushAnimation.value),
              );
            }),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double angle;

  MyPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    Paint circle = Paint()
      ..color = const Color(0xFF414673)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 100, circle);

    Paint paintOutlineCircle = Paint()
      ..color = const Color(0xFFE6E9FD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawCircle(center, 100, paintOutlineCircle);

    Paint centerCircle = Paint()
      ..color = const Color(0xFFE6E9FD)
      ..style = PaintingStyle.fill;

    var second = Paint()
      ..color = const Color(0xFF76A8F4)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var minute = Paint()
      ..color = const Color(0xFFDC73B9)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var hour = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    double secondX = center.dx + 80 * cos(angle - pi / 2);
    double secondY = center.dy + 80 * sin(angle - pi / 2);

    double minuteX = center.dx + 70 * cos((angle / 60 * 2 * pi) - pi / 2);
    double minuteY = center.dy + 70 * sin((angle / 60 * 2 * pi) - pi / 2);

    double hourX = center.dx + 60 * cos((angle / 3600 * 2 * pi) - pi / 2);
    double hourY = center.dy + 60 * sin((angle / 3600 * 2 * pi) - pi / 2);

    canvas.drawLine(center, Offset(secondX, secondY), second);
    canvas.drawLine(center, Offset(minuteX, minuteY), minute);
    canvas.drawLine(center, Offset(hourX, hourY), hour);
    canvas.drawCircle(center, 20, centerCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
