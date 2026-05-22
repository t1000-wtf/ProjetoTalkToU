import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktou_app/src/screens/autismo_screen.dart';
import 'package:talktou_app/src/screens/tdah_screen.dart';
import 'package:talktou_app/src/screens/naoVerbal_screen.dart';
import 'package:talktou_app/src/widgets/optionsPreference_card_widgets.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  String? selectedProfile;

  void _selectProfile(String profile) {
    setState(() {
      selectedProfile = profile;
    });
  }

  void _confirmJourney() {
    if (selectedProfile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, selecione um perfil antes de continuar."),
        ),
      );
      return;
    }

    Widget nextScreen;
    switch (selectedProfile) {
      case "AUTISMO":
        nextScreen = const AutismoScreen();
        break;
      case "TDAH":
        nextScreen = const TdahScreen();
        break;
      case "PESSOA_NAO_VERBAL":
        nextScreen = const NaoVerbalScreen();
        break;
      default:
        nextScreen = const AutismoScreen();
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => nextScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.all_inclusive,
              color: Colors.blueAccent,
              size: 30,
            ),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Bem-vindo!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Selecione o perfil que melhor se adapta às suas necessidades:",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 30),

            ProfileOption(
              icon: Icons.record_voice_over,
              title: "PESSOA NÃO VERBAL",
              subtitle: "Comunicação alternativa",
              color: Colors.redAccent,
              isSelected: selectedProfile == "PESSOA_NAO_VERBAL",
              onTap: () => _selectProfile("PESSOA_NAO_VERBAL"),
            ),

            const SizedBox(height: 30),
            Text(
              "Perfis com Gerenciador de Tarefas",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),

            ProfileOption(
              icon: Icons.psychology,
              title: "AUTISMO",
              subtitle: "Comunicação, rotina, regulação sensorial",
              color: Colors.blueAccent,
              isSelected: selectedProfile == "AUTISMO",
              onTap: () => _selectProfile("AUTISMO"),
            ),
            ProfileOption(
              icon: Icons.bolt,
              title: "TDAH",
              subtitle: "Organização, foco, gestão do tempo",
              color: Colors.orangeAccent,
              isSelected: selectedProfile == "TDAH",
              onTap: () => _selectProfile("TDAH"),
            ),

            const SizedBox(height: 60),

            ElevatedButton(
              onPressed: _confirmJourney,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                "COMEÇAR MINHA JORNADA",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
