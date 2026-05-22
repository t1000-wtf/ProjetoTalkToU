import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktou_app/src/widgets/audio_card.dart';
import 'package:talktou_app/src/widgets/section_title.dart';
import 'package:talktou_app/src/screens/profile_screen.dart';

class NaoVerbalScreen extends StatefulWidget {
  const NaoVerbalScreen({super.key});

  @override
  State<NaoVerbalScreen> createState() => _NaoVerbalScreenState();
}

class _NaoVerbalScreenState extends State<NaoVerbalScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Necessidades'),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                AudioCard(
                  title: 'Água',
                  audioPath: 'assets/audio/agua.mp3',
                  player: _audioPlayer,
                  icon: Icons.local_drink,
                  color: Colors.blue,
                ),
                AudioCard(
                  title: 'Comida',
                  audioPath: 'assets/audio/comida.mp3',
                  player: _audioPlayer,
                  icon: Icons.restaurant,
                  color: Colors.orange,
                ),
                AudioCard(
                  title: 'Banheiro',
                  audioPath: 'assets/audio/banheiro.mp3',
                  player: _audioPlayer,
                  icon: Icons.wc,
                  color: Colors.green,
                ),
                AudioCard(
                  title: 'Descansar',
                  audioPath: 'assets/audio/descansar.mp3',
                  player: _audioPlayer,
                  icon: Icons.king_bed,
                  color: Colors.purple,
                ),
              ],
            ),
            SectionTitle(title: 'Emoções'),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                AudioCard(
                  title: 'Feliz',
                  audioPath: 'assets/audio/feliz.mp3',
                  player: _audioPlayer,
                  icon: Icons.sentiment_very_satisfied,
                  color: Colors.yellow[700]!,
                ),
                AudioCard(
                  title: 'Triste',
                  audioPath: 'assets/audio/triste.mp3',
                  player: _audioPlayer,
                  icon: Icons.sentiment_very_dissatisfied,
                  color: Colors.blueGrey,
                ),
                AudioCard(
                  title: 'Nervoso',
                  audioPath: 'assets/audio/nervoso.mp3',
                  player: _audioPlayer,
                  icon: Icons.mood_bad,
                  color: Colors.red,
                ),
                AudioCard(
                  title: 'Calmo',
                  audioPath: 'assets/audio/calmo.mp3',
                  player: _audioPlayer,
                  icon: Icons.sentiment_satisfied,
                  color: Colors.lightBlueAccent,
                ),
              ],
            ),
            SectionTitle(title: 'Comunicação Rápida'),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                AudioCard(
                  title: 'Sim',
                  audioPath: 'assets/audio/Sim.mp3',
                  player: _audioPlayer,
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                AudioCard(
                  title: 'Não',
                  audioPath: 'assets/audio/nao.mp3',
                  player: _audioPlayer,
                  icon: Icons.cancel,
                  color: Colors.red,
                ),
                AudioCard(
                  title: 'Obrigado',
                  audioPath: 'assets/audio/Obrigado.mp3',
                  player: _audioPlayer,
                  icon: Icons.volunteer_activism,
                  color: Colors.pinkAccent,
                ),
                AudioCard(
                  title: 'Ajuda',
                  audioPath: 'assets/audio/Ajuda.mp3',
                  player: _audioPlayer,
                  icon: Icons.help,
                  color: Colors.orangeAccent,
                ),
              ],
            ),
            SectionTitle(title: 'Rotina'),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                AudioCard(
                  title: 'Escola',
                  audioPath: 'assets/audio/Escola.mp3',
                  player: _audioPlayer,
                  icon: Icons.school,
                  color: Colors.indigo,
                ),
                AudioCard(
                  title: 'Dormir',
                  audioPath: 'assets/audio/Dormir.mp3',
                  player: _audioPlayer,
                  icon: Icons.nights_stay,
                  color: Colors.deepPurple,
                ),
                AudioCard(
                  title: 'Passear',
                  audioPath: 'assets/audio/Passear.mp3',
                  player: _audioPlayer,
                  icon: Icons.directions_walk,
                  color: Colors.lightGreen,
                ),
                AudioCard(
                  title: 'Médico',
                  audioPath: 'assets/audio/Médico.mp3',
                  player: _audioPlayer,
                  icon: Icons.medical_services,
                  color: Colors.redAccent,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
