import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MotivationScreen(),
    );
  }
}

class MotivationScreen extends StatefulWidget {
  @override
  _MotivationScreenState createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  int _currentPage = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _hasPlayedMusic = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Minha princesa, amanhã será um grande dia',
      'colors': [const Color(0xFFB993D6), const Color(0xFF8CA6DB)]
    },
    {
      'text': 'Seu esforço e dedicação vão brilhar na apresentação 🔬',
      'colors': [const Color(0xFFF9A8D4), const Color(0xFFFDCB9E)]
    },
    {
      'text': 'Você é inteligente e preparada, confio plenamente em você 💡',
      'colors': [const Color(0xFFA8E6CF), const Color(0xFFDCEDC1)]
    },
    {
      'text': 'Seja confiante e aproveite o que puder 🎤',
      'colors': [const Color(0xFFFFD3B6), const Color(0xFFFF8B94)]
    },
    {
      'text': 'Eu acredito em você e vou estar torcendo sempre 💖',
      'colors': [const Color(0xFFC3CFE2), const Color(0xFF8E9EAB)]
    },
    {
      'text': 'Te amo princesa ❤️',
      'colors': [const Color(0xFFFF9A9E), const Color(0xFFFAD0C4)]
    },
    // {
    //   'text': '🎵❤️',
    //   'colors': [const Color.fromARGB(255, 36, 36, 36), const Color.fromARGB(255, 45, 0, 168)]
    // },
  ];

  void _nextPage() {
    if (_currentPage < _messages.length - 1) {
      setState(() {
        _currentPage++;
      });
      if (_currentPage == _messages.length - 1 && !_hasPlayedMusic) {
        _playMusic();
      }
    }
  }

  void _playMusic() async {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/audio/music.mp3"),
      showNotification: true,
    );

    setState(() {
      _hasPlayedMusic = true;
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
      body: GestureDetector(
        onTap: _nextPage,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _messages[_currentPage]['colors'],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _messages[_currentPage]['text'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _currentPage < _messages.length - 1
                        ? 'Toque para continuar 👉'
                        : '',
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
