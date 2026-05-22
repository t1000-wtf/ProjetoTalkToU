import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioCard extends StatelessWidget {
  final String title;
  final String audioPath;
  final AudioPlayer player;
  final IconData icon;
  final Color color;

  const AudioCard({
    super.key,
    required this.title,
    required this.audioPath,
    required this.player,
    required this.icon,
    this.color = Colors.blueAccent,
  });

  Future<void> _processarClique() async {
    try {
      await player.stop();

      await player.setAsset(audioPath);

      await player.seek(Duration.zero);

      await player.play();
    } catch (e) {
      debugPrint("Erro ao reproduzir áudio: $audioPath - $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final estaTocando = state?.playing ?? false;

        final bool esteCardEstaTocando =
            estaTocando && state?.processingState != ProcessingState.completed;

        return Card(
          elevation: esteCardEstaTocando ? 8 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: esteCardEstaTocando ? color : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: InkWell(
            onTap: _processarClique,
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: esteCardEstaTocando
                    ? color.withOpacity(0.2)
                    : Colors.white,
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      esteCardEstaTocando ? Icons.pause_circle_filled : icon,
                      key: ValueKey<bool>(esteCardEstaTocando),
                      size: 44,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,

                      fontWeight: esteCardEstaTocando
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
