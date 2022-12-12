import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/list_screen.dart';
import 'package:flutter_firebase/screens/widgets/custom_input_field.dart';
import 'package:flutter_firebase/services/player_service.dart';

import '../models/player.dart';

class UpdatePlayerScreen extends StatefulWidget {
  Player player;
  UpdatePlayerScreen({Key? key, required this.player}) : super(key: key);

  @override
  State<UpdatePlayerScreen> createState() => _UpdatePlayerScreenState();
}

class _UpdatePlayerScreenState extends State<UpdatePlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController clubController = TextEditingController();

  PlayerService playerService = PlayerService();

  @override
  initState() {
    super.initState();
    nameController.text = widget.player.name;
    ageController.text = widget.player.age!;
    countryController.text = widget.player.country;
    clubController.text = widget.player.club!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Update ${widget.player.name}'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomInputField(
                    player: widget.player,
                    label: "Name",
                    controller: nameController,
                    mandatory: true,
                  ),
                  const SizedBox(height: 12.0),
                  CustomInputField(
                      player: widget.player,
                      label: "Age",
                      controller: ageController),
                  const SizedBox(height: 12.0),
                  CustomInputField(
                    player: widget.player,
                    label: "Country",
                    controller: countryController,
                    mandatory: true,
                  ),
                  const SizedBox(height: 12.0),
                  CustomInputField(
                      player: widget.player,
                      label: "Club",
                      controller: clubController),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2.0,
                      primary: Colors.blue,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      final name = nameController.text;
                      final age = ageController.text;
                      final country = countryController.text;
                      final club = clubController.text;

                      if (_formKey.currentState!.validate()) {
                        final updatedPlayer = Player(
                            name: name, age: age, country: country, club: club);

                        playerService.updatePlayer(
                            player: updatedPlayer, id: widget.player.id!);
                        var snackBar = SnackBar(
                          content: Text(
                            '${widget.player.name} updated',
                            style: const TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.orange,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlayerList()),
                        );
                      }

                      nameController.clear();
                      ageController.clear();
                      countryController.clear();
                      clubController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text('Update', style: TextStyle(fontSize: 24)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
