import 'package:flutter/material.dart';

class QuizMode extends StatefulWidget {
  const QuizMode({super.key});

  @override
  State<QuizMode> createState() => _QuizModeState();
}

class _QuizModeState extends State<QuizMode> {
  int groupValue = -1;
  int currentQuestion = 0;
  int score = 0;
  Color resultColor = Colors.black;
  String result = "";

  // Questions and choices based on difficulty level
  final Map<String, List<String>> questions = {
    "Easy": [
      "What does 'Hola' mean?",
      "What does 'Adiós' mean?",
      "What does 'Gracias' mean?",
    ],
    "Medium": [
      "What does '¿Cómo te llamas?' mean?",
      "What does '¿Dónde está el baño?' mean?",
      "What does 'Lo siento' mean?",
    ],
    "Hard": [
      "What does 'Encantado de conocerte' mean?",
      "What does '¿Puede repetirlo, por favor?' mean?",
      "What does 'No hablo mucho español' mean?",
    ],
  };

  final Map<String, List<List<String>>> choices = {
    "Easy": [
      ["Hello", "Goodbye", "Please", "Thank you"],
      ["Thank you", "Goodbye", "Good morning", "Please"],
      ["Please", "Goodbye", "Thank you", "Good morning"],
    ],
    "Medium": [
      ["What is your name?", "How are you?", "Where do you live?", "What time is it?"],
      ["Where is the bathroom?", "How much does it cost?", "Where are you from?", "Can you help me?"],
      ["I'm sorry", "Thank you", "Excuse me", "Goodbye"],
    ],
    "Hard": [
      ["Nice to meet you", "Please help me", "Where are you from?", "Excuse me"],
      ["Can you repeat that, please?", "How old are you?", "Do you speak English?", "Where is the restaurant?"],
      ["I don't speak much Spanish", "I live in Spain", "I like Spanish food", "Spanish is my favorite language"],
    ],
  };

  final Map<String, List<int>> correctAnswers = {
    "Easy": [0, 1, 2],
    "Medium": [0, 0, 0],
    "Hard": [0, 0, 0],
  };

  void checkAnswer(int selectedAnswer) {
    if (selectedAnswer == correctAnswers[currentLevel]![currentQuestion]) {
      result = "Correct!";
      resultColor = Colors.green;
      score++;
    } else {
      result = "Incorrect!";
      resultColor = Colors.red;
    }
    setState(() {
      groupValue = selectedAnswer;
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestion < questions[currentLevel]!.length - 1) {
        currentQuestion++;
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Quiz Completed!'),
            content: Text('Your final score: $score/${questions[currentLevel]!.length}'),
            actions: [
              TextButton(
                child: const Text('Restart'),
                onPressed: () {
                  Navigator.of(context).pop();
                  resetQuiz();
                },
              ),
            ],
          ),
        );
      }
      groupValue = -1;
      result = "";
    });
  }

//restart quiz 
  void resetQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      groupValue = -1;
      result = "";
    });
  }

//QUIZ LEVEL
  String currentLevel = 'Easy';
  int currentIndex = 0;
  bool showEnglish = false;

    void switchLevel(String level) {
    setState(() {
      currentLevel = level;
      currentIndex = 0;
      showEnglish = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentChoices = choices[currentLevel]![currentQuestion];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Take a Quiz ",
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 23)),
            Padding(padding: EdgeInsets.all(10)),
            Text(
            "Level: $currentLevel",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, 
            color: Color.fromRGBO(252, 174, 132, 1)),
          ),
          Padding(padding: EdgeInsets.all(5)),
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
            const SizedBox(height: 10),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  questions[currentLevel]![currentQuestion],
                  style: const TextStyle(
                    color: Color.fromRGBO(252, 174, 132, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Choices
            ...List.generate(currentChoices.length, (i) {
              return Card(
                color: groupValue == i
                    ? (resultColor == Colors.green ? Colors.green.shade100 : Colors.red.shade100)
                    : Colors.white,
                child: ListTile(
                  title: Text(currentChoices[i]),
                  leading: Radio<int>(
                    value: i,
                    groupValue: groupValue,
                    onChanged: (value) => checkAnswer(value!),
                    activeColor: Color.fromRGBO(252, 174, 132, 1),
                  ),
                  onTap: () => checkAnswer(i),
                ),
              );
            }),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(252, 174, 132, 1),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Next",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              result,
              style: TextStyle(
                color: resultColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Score: $score",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(252, 174, 132, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
