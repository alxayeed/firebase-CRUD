import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/update_screen.dart';
import 'package:flutter_firebase/services/player_service.dart';

import '../models/player.dart';

class PlayerInfoScreen extends StatelessWidget {
  final Player player;
  const PlayerInfoScreen({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerService playerService = PlayerService();

    return Scaffold(
      appBar: AppBar(title: Text(player.name)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
        child: Column(
          children: [
            ListTile(
              title: const Text("Name"),
              subtitle: Text(
                player.name,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            ListTile(
              title: const Text("Age"),
              subtitle: Text(
                player.age!,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            ListTile(
              title: const Text("Country"),
              subtitle: Text(
                player.country,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            ListTile(
              title: const Text("Club"),
              subtitle: Text(
                player.club!,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                  primary: Colors.orange,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdatePlayerScreen(player: player,)),
                  );
                },
                child: const Text("Update"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2.0,
                  primary: Colors.red,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  playerService.deletePlayer(id: player.id!);
                  var snackBar = SnackBar(
                    content: Text(
                      '${player.name} deleted',
                      style: const TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                },
                child: const Text("Delete"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
