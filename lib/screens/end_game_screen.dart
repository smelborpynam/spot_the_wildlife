import 'package:flutter/material.dart';
import '../models/player.dart';

class EndGameScreen extends StatelessWidget {
  final List<Player> players;

  const EndGameScreen({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    // Sort players by score (highest first)
    final sorted = [...players]..sort((a, b) => b.score.compareTo(a.score));
    final winner = sorted.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Over"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Winner!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              winner.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "${winner.score} points",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "Final Scores",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: sorted.length,
                itemBuilder: (context, index) {
                  final player = sorted[index];
                  return ListTile(
                    leading: Text(
                      "#${index + 1}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    title: Text(player.name),
                    trailing: Text(
                      "${player.score} pts",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}