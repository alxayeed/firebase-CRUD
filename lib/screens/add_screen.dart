import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/widgets/custom_input_field.dart';

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

  // Future fetchPlayers() async {
  //   var firestore = FirebaseFirestore.instance;
  //   QuerySnapshot querySnapshot = await firestore.collection("Players").get();
  //   return querySnapshot.docs;
  // }

  Future addPlayer({required Player player}) async {
    final docUser = FirebaseFirestore.instance.collection("players").doc();

    player.id = docUser.id;
    await docUser.set(player.toJson());

    var snackBar = SnackBar(
      content: Text(
        '${player.name} added',
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.orange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
                  CustomInputField(label: "name", nameController: nameController, mandatory: true,),
                  const SizedBox(height: 12.0),
                  CustomInputField(label: "Age", nameController: ageController),
                  const SizedBox(height: 12.0),
                  CustomInputField(label: "Country", nameController: ageController, mandatory: true,),
                  const SizedBox(height: 12.0),
                  CustomInputField(label: "Club", nameController: ageController),
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

                        addPlayer(player: player);
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



