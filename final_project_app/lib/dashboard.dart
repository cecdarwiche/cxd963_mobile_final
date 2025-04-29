import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10)),
        Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYBBzJcHcCmddB8IZ9LgjzyyzFuo2ELoRvzoYdf0Bu7FfpsnQRZvNe1vT7fSGp8URF6Fc&usqp=CAU", width: 400),
        Padding(padding: EdgeInsets.all(10)),
        Text("Let's learn some basic Spanish!", 
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(252, 174, 132, 1),
          fontSize: 30, fontWeight: FontWeight.w600)),
        Padding(padding: EdgeInsets.all(15),
        child: 
        Text("Learn basic Spanish words for everyday use! You can use flashcards, quiz your knowledge, and explore the word of the day. ",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 23))
        ),
        //Navigator
        Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
          style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(252, 174, 132, 1),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('More Information',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
        ),
      ),
        
        
      ]
    );
  }
}

//Navigator Second Route (Instructions for SpanishSplash)
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(252, 174, 132, 1),
        title: const Text(
          "SPANISH SPLASH",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 30),
        ),),
      body: 
      Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(70)),
          Text("Using Spanish Splash you can learn basic Spanish words in different levels! You can go to the flashcards tab to learn new words or to the quiz tab to test your new knowledge. If you would like to have more fun, you can also explore the Spanish word of the day!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23)),
          Padding(padding: EdgeInsets.all(40)),
          Center( 
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(252, 174, 132, 1),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Back to Dashboard!',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}

