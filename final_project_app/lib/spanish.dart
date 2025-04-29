import 'package:flutter/material.dart';


class Spanish extends StatefulWidget {
  const Spanish({super.key});

  @override
  State<Spanish> createState() => _SpanishState();
}

class _SpanishState extends State<Spanish> {
  final Map<String, List<Map<String, String>>> flashcards = {
    'Easy': [
      {'spanish': 'Hola', 'english': 'Hello'},
      {'spanish': 'Adiós', 'english': 'Goodbye'},
      {'spanish': 'Gracias', 'english': 'Thank you'},
    ],
    'Medium': [
      {'spanish': 'Buenos días', 'english': 'Good morning'},
      {'spanish': '¿Cómo estás?', 'english': 'How are you?'},
      {'spanish': '¿Cómo te llamas?', 'english': 'What is your name?'},
    ],
    'Hard': [
      {'spanish': 'Encantado de conocerte', 'english': 'Nice to meet you'},
      {'spanish': '¿Dónde está el baño?', 'english': 'Where is the bathroom?'},
      {'spanish': 'Necesito ayuda', 'english': 'I need help'},
    ],
  };

  String currentLevel = 'Easy';
  int currentIndex = 0;
  bool showEnglish = false;

  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % flashcards[currentLevel]!.length;
      showEnglish = false;
    });
  }

  void switchLevel(String level) {
    setState(() {
      currentLevel = level;
      currentIndex = 0;
      showEnglish = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = flashcards[currentLevel]![currentIndex];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Practice with Flashcards ",
            textAlign: TextAlign.center,
            style: TextStyle(
            fontSize: 23)),
          Padding(padding: EdgeInsets.all(20)),
          Text(
            "Level: $currentLevel",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, 
            color: Color.fromRGBO(252, 174, 132, 1)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => switchLevel('Easy'),
                child: const Text('Easy'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => switchLevel('Medium'),
                child: const Text('Medium'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => switchLevel('Hard'),
                child: const Text('Hard'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                showEnglish = !showEnglish;
              });
            },
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(40),
                child: Text(
                  showEnglish ? card['english']! : card['spanish']!,
                  style: const TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: nextCard,
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(252, 174, 132, 1),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),),
            child: const Text(
                "Next",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
          ),
        ],
      ),
    );
  }
}
