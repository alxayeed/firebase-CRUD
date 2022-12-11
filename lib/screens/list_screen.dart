import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/add_screen.dart';
import 'package:flutter_firebase/screens/widgets/player_info_tile.dart';
import 'package:flutter_firebase/services/player_service.dart';

import '../models/player.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({Key? key}) : super(key: key);

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  PlayerService playerService = PlayerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player list"),
        elevation: 0.0,
      ),
      body: StreamBuilder<List<Player>>(
        stream: playerService.fetchPlayers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('An error occured ${snapshot.error}');
          } else if (snapshot.hasData) {
            final players = snapshot.data;
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Player player = snapshot.data![index];
                return PlayerInfoTile(player: player);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlayer()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


