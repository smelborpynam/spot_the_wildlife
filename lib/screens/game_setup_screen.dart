import 'package:flutter/material.dart';
import '../models/player.dart';
import 'game_screen.dart';

class GameSetupScreen extends StatefulWidget {
  const GameSetupScreen({super.key});

  @override
  State<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends State<GameSetupScreen> {
  final TextEditingController _playerController = TextEditingController();
  final List<Player> players = [];

  void addPlayer() {
    final name = _playerController.text.trim();
    if (name.isEmpty) return;

    setState(() {
      players.add(Player(name: name));
      _playerController.clear();
    });
  }

void startGame() {
  if (players.isEmpty) return;

  // Reset scores for a new game
  for (var player in players) {
    player.score = 0;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => GameScreen(players: players),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Setup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _playerController,
              decoration: InputDecoration(
                labelText: "Player Name",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addPlayer,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(players[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          players.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: startGame,
              child: const Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }
}