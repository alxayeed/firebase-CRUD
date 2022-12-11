import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/add_screen.dart';
import 'package:flutter_firebase/screens/widgets/player_info_tile.dart';

import '../models/player.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({Key? key}) : super(key: key);

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  Stream<List<Player>> fetchPlayers() => FirebaseFirestore.instance
      .collection("players")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Player.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player list"),
        elevation: 0.0,
      ),
      body: StreamBuilder<List<Player>>(
        stream: fetchPlayers(),
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
        child: Icon(Icons.add),
      ),
    );
  }
}


