import 'package:flutter/material.dart';

class MoodButton extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  const MoodButton({
    super.key,
    required this.text,
    required this.color,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: isSelected ? Colors.white : Colors.black),
      label: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : Colors.grey[300],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
