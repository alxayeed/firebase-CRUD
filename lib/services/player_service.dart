import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/player.dart';

class PlayerService {
  Stream<List<Player>> fetchPlayers() => FirebaseFirestore.instance
      .collection("players")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Player.fromJson(doc.data())).toList());

  Future addPlayer({required Player player}) async {
    final docUser = FirebaseFirestore.instance.collection("players").doc();

    player.id = docUser.id;
    await docUser.set(player.toJson());
  }
}