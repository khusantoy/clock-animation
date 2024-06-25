import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class _MyHomePageState extends State<MyHomePage> {
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
        child: CustomPaint(
          size: const Size(300, 300),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paintCircle = Paint();
    paintCircle.color = const Color(0xFF414673);
    paintCircle.style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), 120, paintCircle);

    var paintOutlineCircle = Paint();
    paintOutlineCircle.color = Colors.white;
    paintOutlineCircle.style = PaintingStyle.stroke;
    paintOutlineCircle.strokeWidth = 13;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), 120, paintOutlineCircle);

    var centerCircle = Paint();
    centerCircle.color = Colors.white;
    centerCircle.style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), 15, centerCircle);

    var secund = Paint();
    secund.color = const Color(0xFFFAB64B);
    secund.style = PaintingStyle.stroke;
    secund.strokeWidth = 10;
    secund.strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    path.lineTo(size.width / 2, size.height / 2 - 80);

    canvas.drawPath(path, secund);

    var minute = Paint();
    minute.color = const Color(0xFF6FA5F5);
    minute.style = PaintingStyle.stroke;
    minute.strokeWidth = 10;
    minute.strokeCap = StrokeCap.round;

    final path2 = Path();
    path.moveTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, 0);

    canvas.drawPath(path2, minute);
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return false;
  }
}
