import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/animal.dart';
import '../data/animals.dart';
import 'scoreboard_screen.dart';
import 'end_game_screen.dart';
import 'animal_detail_screen.dart';



class GameScreen extends StatefulWidget {
  final List<Player> players;

  const GameScreen({super.key, required this.players});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  void awardPoints(Player player, Animal animal) {
    setState(() {
      player.score += animal.points;
    });
  }

  void showPlayerPicker(Animal animal) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: widget.players.map((player) {
            return ListTile(
              title: Text(player.name),
              trailing: Text("+${animal.points}"),
              onTap: () {
                Navigator.pop(context);
                awardPoints(player, animal);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void openScoreboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ScoreboardScreen(players: widget.players),
      ),
    );
  }
void openAnimalDetail(Animal animal) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AnimalDetailScreen(
        animal: animal,
        players: widget.players,
      ),
    ),
  ).then((_) {
    setState(() {}); // refresh scores after returning
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: const Text("Spot the Wildlife"),
  actions: [
    IconButton(
      icon: const Icon(Icons.flag),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EndGameScreen(players: widget.players),
          ),
        );
      },
    ),
  ],
),

      floatingActionButton: FloatingActionButton(
        onPressed: openScoreboard,
        child: const Icon(Icons.leaderboard),
      ),
      body: GridView.builder(
  padding: const EdgeInsets.all(12),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    childAspectRatio: 0.8,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  itemCount: animals.length,
  itemBuilder: (context, index) {
    final animal = animals[index];
    return GestureDetector(
      onTap: () => openAnimalDetail(animal),
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                animal.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 40, color: Colors.red);
                },
              ),
            ),
            const SizedBox(height: 6),
            Text(
              animal.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("+${animal.points} pts"),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  },
),
    );
  }
}