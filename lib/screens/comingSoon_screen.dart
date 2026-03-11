
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🔽 🛠️ 🛠️ 
                Image.asset( 'assets/Img/comingSoon.jpg', height: 200),
                SizedBox(height: 30),
                Text( 
                  'Coming Soon',
                   style: TextStyle( fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    ),
                ),
                SizedBox(height: 10),
                Text(
                  'We are working on something amazing.\nStay tuned!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

