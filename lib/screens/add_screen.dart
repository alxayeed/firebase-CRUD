import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/widgets/custom_input_field.dart';
import 'package:flutter_firebase/services/player_service.dart';

import '../models/player.dart';

class AddPlayer extends StatefulWidget {
  const AddPlayer({Key? key}) : super(key: key);

  @override
  State<AddPlayer> createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController clubController = TextEditingController();

  PlayerService playerService = PlayerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('Add player'),
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
                    label: "Name",
                    controller: nameController,
                    mandatory: true,
                  ),
                  const SizedBox(height: 12.0),
                  CustomInputField(label: "Age", controller: ageController),
                  const SizedBox(height: 12.0),
                  CustomInputField(
                    label: "Country",
                    controller: countryController,
                    mandatory: true,
                  ),
                  const SizedBox(height: 12.0),
                  CustomInputField(label: "Club", controller: clubController),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2.0,
                      primary: Colors.orange,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      final name = nameController.text;
                      final age = ageController.text;
                      final country = countryController.text;
                      final club = clubController.text;

                      if (_formKey.currentState!.validate()) {
                        final player = Player(
                            name: name, age: age, country: country, club: club);

                        playerService.addPlayer(player: player);
                        var snackBar = SnackBar(
                          content: Text(
                            '${player.name} added',
                            style: const TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.orange,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      nameController.clear();
                      ageController.clear();
                      countryController.clear();
                      clubController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text('Save', style: TextStyle(fontSize: 24)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
