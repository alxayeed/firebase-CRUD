import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/player.dart';

class PlayerService {
  Stream<List<Player>> fetchPlayers() => FirebaseFirestore.instance
      .collection("players")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => Player.fromJson(doc.data())).toList());

  Future<Player?> fetchPlayer(String id) async {
    final docUser = FirebaseFirestore.instance.collection("players").doc("doc-id");
    final snapShot = await docUser.get();

    if(snapShot.exists){
      return Player.fromJson(snapShot.data()!);
    }
  }

  Future addPlayer({required Player player}) async {
    final docUser = FirebaseFirestore.instance.collection("players").doc();

    player.id = docUser.id;
    await docUser.set(player.toJson());
  }

  Future updatePlayer({required Player player, required String id}) async {
    final docUser = FirebaseFirestore.instance.collection("players").doc(
        'doc-id');

    player.id = docUser.id;
    await docUser.update(player.toJson());
  }

  Future deletePlayer({required Player player, required String id}) async {
    final docUser = FirebaseFirestore.instance.collection("players").doc(
        'doc-id');

    await docUser.delete();
  }
}