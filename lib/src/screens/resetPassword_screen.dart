import 'package:flutter/material.dart';
import 'package:talktou_app/src/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Redefinir Senha',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.all_inclusive,
                    color: Colors.blueAccent,
                    size: 60,
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 32, letterSpacing: -1),
                      children: [
                        TextSpan(
                          text: 'Talk',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        TextSpan(
                          text: 'ToU',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // CustomTextField(
            //   label: "Senha Antiga",
            //   hint: "Digite sua senha antiga",
            //   icon: Icons.lock_outlined,
            // ),
            CustomTextField(
              label: "Senha Nova",
              hint: "Digite sua senha nova",
              icon: Icons.lock_outline,
            ),
            CustomTextField(
              label: "Confirmar Senha Nova",
              hint: "Confirme sua senha nova",
              icon: Icons.lock_outline,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "CONFIRMAR",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: Colors.grey.shade400,
                  size: 35,
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Seus dados estão protegidos.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Privacidade e segurança são nossas prioridades.",
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
