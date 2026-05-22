import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: isSelected ? 6 : 3,
      color: isSelected ? color.withAlpha(30) : Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withAlpha(50),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: GoogleFonts.orbitron(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ?Colors.blueAccent : Colors.black,
          ),
        ),
        subtitle: Text(subtitle, style: GoogleFonts.poppins(fontSize: 14)),
        onTap: onTap,
        trailing: isSelected ? const Icon(Icons.check, color: Colors.blueAccent): null,
      ),
    );
  }
}
