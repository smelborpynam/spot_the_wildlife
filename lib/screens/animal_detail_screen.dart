import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../models/player.dart';

class AnimalDetailScreen extends StatelessWidget {
  final Animal animal;
  final List<Player> players;

  const AnimalDetailScreen({
    super.key,
    required this.animal,
    required this.players,
  });

  void awardPoints(BuildContext context, Player player) {
    player.score += animal.points;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(animal.imagePath, height: 200),
            const SizedBox(height: 20),
            Text(
              animal.fact,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Text(
              "Who spotted it?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: players.map((player) {
                  return ListTile(
                    title: Text(player.name),
                    trailing: Text("+${animal.points}"),
                    onTap: () => awardPoints(context, player),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}