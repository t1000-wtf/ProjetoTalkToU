import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class SoundsrelaxScreen extends StatefulWidget {
  const SoundsrelaxScreen({super.key});

  @override
  State<SoundsrelaxScreen> createState() => _SoundsrelaxScreenState();
}

class _SoundsrelaxScreenState extends State<SoundsrelaxScreen> {
  String? playingSound;
  bool isPlaying = false;
  double volume = 0.5;

  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, dynamic>> sounds = [
    {
      'name': 'Chuva Suave',
      'icon': Icons.umbrella,
      'color': Colors.blue,
      'asset': 'assets/audio/rain.mp3',
    },
    {
      'name': 'Ruído Branco',
      'icon': Icons.waves,
      'color': Colors.grey,
      'asset': 'audio/ruido.mp3',
    },
    {
      'name': 'Floresta',
      'icon': Icons.forest,
      'color': Colors.green,
      'asset': 'audio/forest.mp3',
    },
    {
      'name': 'Oceano',
      'icon': Icons.water,
      'color': Colors.cyan,
      'asset': 'audio/ocean_waves.mp3',
    },
    {
      'name': 'Fogo',
      'icon': Icons.local_fire_department,
      'color': Colors.orange,
      'asset': 'audio/fire.mp3',
    },
    {
      'name': 'Meditação',
      'icon': Icons.self_improvement,
      'color': Colors.purple,
      'asset': 'audio/meditation.mp3',
    },
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer.setVolume(volume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleSound(String name, String? assetPath) async {
    if (playingSound == name) {
      if (isPlaying) {
        setState(() => isPlaying = false);
        await _audioPlayer.pause();
        return;
      }
      setState(() => isPlaying = true);
      await _audioPlayer.play();
      return;
    }

    if (assetPath == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Áudio não disponível para este som no momento.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      playingSound = name;
      isPlaying = true;
    });

    try {
      await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.setLoopMode(LoopMode.one);
      await _audioPlayer.play();
    } catch (e) {
      setState(() {
        playingSound = null;
        isPlaying = false;
      });
    }
  }

  Future<void> _stopSound() async {
    setState(() {
      playingSound = null;
      isPlaying = false;
    });
    await _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Sons Relaxantes',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Escolha um ambiente para relaxar ou se concentrar.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
              ),
              itemCount: sounds.length,
              itemBuilder: (context, index) {
                final sound = sounds[index];
                final name = sound['name'] as String;
                final isPlayingSound = playingSound == name;
                final color = sound['color'] as Color;
                final icon = sound['icon'] as IconData;
                final asset = sound['asset'] as String?;

                return GestureDetector(
                  onTap: () => _toggleSound(name, asset),
                  child: Container(
                    decoration: BoxDecoration(
                      color: asset == null
                          ? Colors.grey[100]
                          : isPlayingSound
                          ? color.withOpacity(0.2)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isPlayingSound ? color : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              size: 40,
                              color: asset == null
                                  ? Colors.grey[400]
                                  : isPlayingSound
                                  ? color
                                  : Colors.grey[400],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: asset == null
                                    ? Colors.grey
                                    : isPlayingSound
                                    ? color
                                    : Colors.black54,
                              ),
                            ),
                            if (isPlayingSound && isPlaying)
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Icon(
                                  Icons.equalizer,
                                  size: 16,
                                  color: Colors.blueAccent,
                                ),
                              ),
                          ],
                        ),
                        if (asset == null)
                          Positioned(
                            bottom: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Em breve',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (playingSound != null)
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.volume_down, color: Colors.grey),
                      Expanded(
                        child: Slider(
                          value: volume,
                          onChanged: (val) {
                            setState(() => volume = val);
                            _audioPlayer.setVolume(val);
                          },
                          activeColor: Colors.blueAccent,
                        ),
                      ),
                      const Icon(Icons.volume_up, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 42,
                        color: Colors.blueAccent,
                        icon: Icon(
                          isPlaying ? Icons.pause_circle : Icons.play_circle,
                        ),
                        onPressed: () async {
                          setState(() => isPlaying = !isPlaying);

                          if (!isPlaying) {
                            await _audioPlayer.pause();
                          } else {
                            await _audioPlayer.play();
                          }
                        },
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        iconSize: 32,
                        color: Colors.grey,
                        icon: const Icon(Icons.stop_circle),
                        onPressed: _stopSound,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isPlaying
                        ? 'Tocando agora: $playingSound'
                        : 'Pausado: $playingSound',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
