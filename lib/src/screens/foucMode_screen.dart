import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/adjust_button.dart';
import '../widgets/timer_button.dart';

class FoucmodeScreen extends StatefulWidget {
  const FoucmodeScreen({super.key});

  @override
  State<FoucmodeScreen> createState() => _FoucmodeScreenState();
}

class _FoucmodeScreenState extends State<FoucmodeScreen> {
  Timer? _timer;
  int _initialSeconds = 25 * 60;
  int _secondsRemaining = 25 * 60;
  bool _isRunning = false;
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateControllerText();
  }

  void _updateControllerText() {
    if (_secondsRemaining <= 0) {
      _timeController.text = '0';
      return;
    }
    int minutes = _secondsRemaining ~/ 60;
    _timeController.text = minutes.toString();
  }

  void _startTimer() {
    if (_isRunning) return;
    if (_secondsRemaining <= 0) return;

    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _stopTimer();
        }
      });
    });
  }

  void _applyInputTime() {
    int? minutes = int.tryParse(_timeController.text);
    if (minutes != null && minutes >= 0) {
      setState(() {
        _secondsRemaining = minutes * 60;
        _initialSeconds = _secondsRemaining;
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _secondsRemaining = 0;
      _initialSeconds = 0;
      _updateControllerText();
    });
  }

  void _adjustTime(int minutes) {
    if (_isRunning) return;
    int currentMinutes = int.tryParse(_timeController.text) ?? (_secondsRemaining ~/ 60);
    int newMinutes = currentMinutes + minutes;

    if (newMinutes >= 1 && newMinutes <= 120) {
      setState(() {
        _secondsRemaining = newMinutes * 60;
        _initialSeconds = _secondsRemaining;
        _updateControllerText();
      });
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _secondsRemaining / (_initialSeconds > 0 ? _initialSeconds : 1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Modo Foco",
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Mantenha a concentração",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),

              if (!_isRunning)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdjustButton(icon: Icons.remove, onPressed: () => _adjustTime(-5)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Ajustar minutos",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                    ),
                    AdjustButton(icon: Icons.add, onPressed: () => _adjustTime(5)),
                  ],
                )
              else
                const SizedBox(height: 48),

              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CircularProgressIndicator(
                      value: _isRunning ? progress : 1.0,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _isRunning ? Colors.orangeAccent : Colors.orangeAccent.withValues(alpha:0.3),
                      ),
                    ),
                  ),
                  if (_isRunning || (_secondsRemaining > 0 && _secondsRemaining != _initialSeconds))
                    Text(
                      _formatTime(_secondsRemaining),
                      style: GoogleFonts.orbitron(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )
                  else
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: _timeController,
                        onChanged: (value) => _applyInputTime(),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: GoogleFonts.orbitron(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "00",
                          suffixText: " m",
                          suffixStyle: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        onSubmitted: (_) => _startTimer(),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerButton(
                    onPressed: _isRunning ? _stopTimer : _startTimer,
                    icon: _isRunning ? Icons.pause : Icons.play_arrow,
                    label: _isRunning ? "Pausar" : "Iniciar",
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(width: 12),
                  TimerButton(
                    onPressed: _resetTimer,
                    icon: Icons.refresh,
                    label: "Resetar",
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Dica: Tente focar em apenas uma tarefa por vez para reduzir a ansiedade",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Dica: Clique no meio da tela para ajustar o tempo.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}