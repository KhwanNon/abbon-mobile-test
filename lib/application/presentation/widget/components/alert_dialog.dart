import 'dart:async';

import 'package:flutter/material.dart';

enum AlertType { success, fail }

class AlertDialogComponent extends StatefulWidget {
  final AlertType type;
  final String message;

  const AlertDialogComponent({super.key, required this.type, required this.message});

  @override
  State<AlertDialogComponent> createState() => _AlertDialogComponentState();
}

class _AlertDialogComponentState extends State<AlertDialogComponent> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = widget.type == AlertType.success ? Colors.green.shade700 : Colors.red.shade700;
    final IconData icon = widget.type == AlertType.success ? Icons.check_circle : Icons.error;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 70, color: iconColor),
            const SizedBox(height: 16),
            Text(widget.message, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
