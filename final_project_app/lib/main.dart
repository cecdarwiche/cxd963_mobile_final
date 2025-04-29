import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'Spanish.dart';
import 'quizMode.dart';
import 'wordCard.dart'; 

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;


void main() {
  runApp(const LearnLang());
}

class LearnLang extends StatelessWidget {
  const LearnLang({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LearnLangApp(),
    );
  }
}

class LearnLangApp extends StatefulWidget {
  const LearnLangApp({super.key});

  @override
  State<LearnLangApp> createState() => _LearnLangAppState();
}

class _LearnLangAppState extends State<LearnLangApp> {
  int currentIndex = 0;

  //word of the day
  List<String> randomWords = [];
  Set<String> pickedWords = {};
  final int cards = 3;
 

  @override
  void initState() {
    super.initState();
    fetchJSON();
  }

  // Make a network request (function to fetch data)
  Future<void> fetchJSON() async{
    const url = 'https://raw.githubusercontent.com/bitcoinjs/bip39/refs/heads/master/ts_src/wordlists/spanish.json';
    final output = await http.get(Uri.parse(url));
    final rand = Random();

    final List<dynamic> words = jsonDecode(output.body);

    //fisd 3 random words
    while (pickedWords.length < cards) {
          pickedWords.add(words[rand.nextInt(words.length)]);
        }
  
    setState(() {
      randomWords = pickedWords.toList();
      
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(252, 174, 132, 1),
        title: const Text(
          "SPANISH SPLASH",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 30),
        ),),
      body: Center(
        child: [
          const Dashboard(),
          const Spanish(),
          const QuizMode(),
          ListView(children: <Widget>[
            Padding( padding: EdgeInsets.all(20)),
            Text("Your Spanish Words of the Day",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23
            ) ),
            Text("Challenge yourself by researching the meaning of these words!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18
            ) ),
            Padding( padding: EdgeInsets.all(10)),
            WordCard(
                word: randomWords[0],
                subtitle: "Easy Spanish Word of the Day",
              ),
            WordCard(
                word: randomWords[1],
                subtitle: "Intermediate Spanish Word of the Day",
            ),
            WordCard(
                word: randomWords[2],
                subtitle: "Hard Spanish Word of the Day",
            ), 
          ]),
          //const Word(),
        ][currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        indicatorColor: Color.fromRGBO(252, 174, 132, 1),
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.book_online),
            label: "Flashcards",
          ),
          NavigationDestination(
            icon: Icon(Icons.grade),
            label: "Quiz",
          ),
          NavigationDestination(
            icon: Icon(Icons.alarm),
            label: "Today's Word",
          ),
        ],
      ),
    );
  }
}
