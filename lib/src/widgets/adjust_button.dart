import 'package:flutter/material.dart';

class AdjustButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const AdjustButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.orangeAccent),
      style: IconButton.styleFrom(
        backgroundColor: Colors.orange[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
