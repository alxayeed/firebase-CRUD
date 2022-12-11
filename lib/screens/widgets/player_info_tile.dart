import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/player_info_screen.dart';

import '../../models/player.dart';

class PlayerInfoTile extends StatelessWidget {
  const PlayerInfoTile({
    Key? key,
    required this.player,
  }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          player.name,
        ),
        subtitle: Text(player.country),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlayerInfoScreen(player: player)),
          );
        },
      ),
    );
  }
}
