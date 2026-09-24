import 'package:flutter/material.dart';

class Animationbutton extends StatefulWidget {
  const Animationbutton({super.key});

  @override
  State<Animationbutton> createState() => _AnimationbuttonState();
}

class _AnimationbuttonState extends State<Animationbutton>
    with SingleTickerProviderStateMixin {
  bool isSend = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _doneAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        )..addListener(() {
          setState(() {});
        });

    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(6, 0)).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        )..addListener(() {
          setState(() {});
        });

    _colorAnimation =
        ColorTween(
            begin: const Color(0xFF2E9BF5),
            end: const Color(0xFF2ECC71),
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          )
          ..addListener(() {
            setState(() {});
          });

    _doneAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        )..addListener(() {
          setState(() {});
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                _controller.forward();
              },
              child: Container(
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                  color: _colorAnimation.value,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: (_colorAnimation.value ?? Colors.blue).withAlpha(
                        3,
                      ),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideTransition(
                        position: _slideAnimation,
                        child: Icon(Icons.send, color: Colors.white, size: 40),
                      ),

                      SizedBox(width: 10),

                      Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Text(
                          'send',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Transform.scale(
              scale: _doneAnimation.value,
              child: Padding(
                padding: const EdgeInsetsGeometry.only(left: 155, top: 15),
                child: Icon(Icons.done, color: Colors.white, size: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
