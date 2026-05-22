import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktou_app/src/widgets/lista_tarefas.dart';
import 'package:talktou_app/src/screens/profile_screen.dart';
import 'package:talktou_app/src/screens/soundsRelax_screen.dart';
import 'package:talktou_app/src/widgets/mood_buton.dart';

class AutismoScreen extends StatefulWidget {
  const AutismoScreen({super.key});

  @override
  State<AutismoScreen> createState() => _AutismoScreenState();
}

class _AutismoScreenState extends State<AutismoScreen> {
  String? selectedMood; // guarda o humor escolhido
  final ScrollController _scrollController =
      ScrollController(); // Controlador de scroll

  // Insight dinâmico
  String _getInsight() {
    switch (selectedMood) {
      case "Triste":
        return "Respire fundo, você está indo bem 💙";
      case "Neutro":
        return "Equilíbrio é importante, continue assim ⚖️";
      case "Bem":
        return "Ótimo progresso hoje! 🌟";
      default:
        return "Selecione como você está para receber um insight personalizado.";
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Liberar recursos
    super.dispose();
  }

  // Função para rolar até o fim da tela
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.all_inclusive, color: Colors.blueAccent, size: 30),
            const SizedBox(width: 8),
            Text(
              "TalkToU",
              style: GoogleFonts.orbitron(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.blueAccent,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        controller: _scrollController, // Atribui o controlador
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Olá, Alex!",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Como você está hoje?",
              style: GoogleFonts.poppins(fontSize: 18),
            ),

            const SizedBox(height: 15),
            // Botões de humor com ícones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MoodButton(
                  text: "Triste",
                  color: Colors.red,
                  icon: Icons.sentiment_dissatisfied,
                  isSelected: selectedMood == "Triste",
                  onPressed: () {
                    setState(() => selectedMood = "Triste");
                    _scrollToBottom();
                  },
                ),
                MoodButton(
                  text: "Neutro",
                  color: Colors.grey,
                  icon: Icons.sentiment_neutral,
                  isSelected: selectedMood == "Neutro",
                  onPressed: () {
                    setState(() => selectedMood = "Neutro");
                    _scrollToBottom();
                  },
                ),
                MoodButton(
                  text: "Bem",
                  color: Colors.green,
                  icon: Icons.sentiment_satisfied,
                  isSelected: selectedMood == "Bem",
                  onPressed: () {
                    setState(() => selectedMood = "Bem");
                    _scrollToBottom();
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),
            Text(
              "Tarefas",
              style: GoogleFonts.orbitron(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Usando o componente de tarefas
            const TaskManager(),

            const SizedBox(height: 30),

            // Botão de sons relaxantes
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SoundsrelaxScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.music_note, color: Colors.white),
              label: Text(
                "Sons Relaxantes",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 30),
            // Insight dinâmico em card colorido
            Card(
              color: selectedMood == "Triste"
                  ? Colors.red[100]
                  : selectedMood == "Neutro"
                  ? Colors.grey[300]
                  : selectedMood == "Bem"
                  ? Colors.green[100]
                  : Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _getInsight(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
