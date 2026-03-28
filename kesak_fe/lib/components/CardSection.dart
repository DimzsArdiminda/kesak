import 'package:flutter/material.dart';
import 'package:kesak_fe/components/Colors.dart';

class CardSection extends StatelessWidget {
  final String title;
  final String body;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? borderRadius;

  const CardSection({
    super.key,
    required this.title,
    required this.body,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor ?? textColorW,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
