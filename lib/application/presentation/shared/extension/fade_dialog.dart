import 'package:flutter/material.dart';

class FadeTransitionDialog extends StatefulWidget {
  final Widget child;

  const FadeTransitionDialog({super.key, required this.child});

  @override
  State<FadeTransitionDialog> createState() => _FadeTransitionDialogState();
}

class _FadeTransitionDialogState extends State<FadeTransitionDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}
