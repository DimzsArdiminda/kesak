import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final String lottieAsset;
  final double width;
  final double height;
  final Color backgroundColor;
  final double borderRadius;
  final bool showBlur;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    this.lottieAsset = 'lib/assets/all/Loading_animation.json',
    this.width = 100,
    this.height = 100,
    this.backgroundColor = Colors.white,
    this.borderRadius = 15,
    this.showBlur = true,
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
          boxShadow: showBlur
              ? [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Lottie.asset(
          lottieAsset,
          repeat: true,
        ),
      ),
    );
  }
}
