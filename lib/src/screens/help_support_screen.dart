import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/support_card.dart';
import '../widgets/faq_item.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ajuda & Suporte",
          style: GoogleFonts.orbitron(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dúvidas Comuns",
              style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 15),
            const FaqItem(
              question: "Como altero meu perfil?",
              answer: "Vá em 'Meu Perfil' > 'Editar Perfil'.",
            ),
            const FaqItem(
              question: "O que é o Modo Foco?",
              answer: "Uma ferramenta para ajudar na concentração durante tarefas.",
            ),
            const FaqItem(
              question: "Meus dados estão seguros?",
              answer: "Sim, seguimos rigorosas políticas de privacidade.",
            ),
          ],
        ),
      ),
    );
  }
}
