import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final double width;
  final double height;
  final String animationPath;
  final Color backgroundColor;
  final double borderRadius;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    this.width = 100,
    this.height = 100,
    this.animationPath = 'lib/assets/all/Loading_animation.json',
    this.backgroundColor = Colors.white,
    this.borderRadius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Lottie.asset(
          animationPath,
          repeat: true,
        ),
      ),
    );
  }
}
