import 'package:flutter/material.dart';
import '../models/player.dart';

class ScoreboardScreen extends StatelessWidget {
  final List<Player> players;

  const ScoreboardScreen({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    // Sort players by score (highest first)
    final sortedPlayers = [...players]
      ..sort((a, b) => b.score.compareTo(a.score));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scoreboard"),
      ),
      body: ListView.builder(
        itemCount: sortedPlayers.length,
        itemBuilder: (context, index) {
          final player = sortedPlayers[index];

          return Card(
            child: ListTile(
              leading: Text(
                "#${index + 1}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              title: Text(
                player.name,
                style: const TextStyle(fontSize: 18),
              ),
              trailing: Text(
                "${player.score} pts",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}