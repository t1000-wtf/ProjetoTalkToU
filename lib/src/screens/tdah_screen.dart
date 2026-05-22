import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktou_app/src/screens/foucMode_screen.dart';
import 'package:talktou_app/src/widgets/lista_tarefas.dart';
import 'package:talktou_app/src/screens/profile_screen.dart';
import 'package:talktou_app/src/widgets/mood_buton.dart';

class TdahScreen extends StatefulWidget {
  const TdahScreen({super.key});

  @override
  State<TdahScreen> createState() => _TdahScreenState();
}

class _TdahScreenState extends State<TdahScreen> {
  String? selectedMood;
  final ScrollController _scrollController = ScrollController();

  String _getInsight() {
    switch (selectedMood) {
      case "Triste":
        return "Lembre-se: cada passo conta. Respire fundo e siga em frente 💜";
      case "Neutro":
        return "Você está mantendo o equilíbrio. Continue firme! ⚖️";
      case "Bem":
        return "Ótimo progresso hoje! Continue espalhando energia positiva ✨";
      default:
        return "Selecione como você está para receber um insight personalizado.";
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            Text("TalkToU",
              style: GoogleFonts.orbitron(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.blueAccent, size: 30),
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
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Olá, Alex!",
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Como você está hoje?",
              style: GoogleFonts.poppins(fontSize: 18),
            ),

            const SizedBox(height: 15),
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
            Text("Tarefas",
              style: GoogleFonts.orbitron(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const TaskManager(),

            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const FoucmodeScreen()));
              },
              icon: const Icon(Icons.center_focus_strong),
              label: Text("Modo Foco",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 30),
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
