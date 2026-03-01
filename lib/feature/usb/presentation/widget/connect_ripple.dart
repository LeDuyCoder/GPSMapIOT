import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpsmapiot/core/theme/app_color.dart';

class ConnectRipple extends StatefulWidget {
  const ConnectRipple({super.key});

  @override
  State<ConnectRipple> createState() => _ConnectRippleState();
}

class _ConnectRippleState extends State<ConnectRipple>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
  AnimationController(vsync: this, duration: const Duration(seconds: 5))
    ..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ===== Ripple waves =====
          for (int i = 0; i < 1; i++)
            AnimatedBuilder(
              animation: _c,
              builder: (_, __) {
                final progress = (_c.value + i * 0.33) % 1;
                final size = 120 + progress * 320;
                final radius = 20 + progress * 60;

                return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.2 * (1 - progress)),
                      width: 100,
                    ),
                  ),
                );
              },
            ),

          // ===== Center container =====
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(color: AppColor.primaryColor, blurRadius: 25),
              ],
            ),
            child: Center(
              child: Image.asset("assets/images/pic2.png"),
            ),
          ),
        ],
      ),
    );
  }
}