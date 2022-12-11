import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  // Future fetchPlayers() async {
  //   var firestore = FirebaseFirestore.instance;
  //   QuerySnapshot querySnapshot = await firestore.collection("Players").get();
  //   return querySnapshot.docs;
  // }

  Future addPlayer({required String name}) async {
    final docUser =
        FirebaseFirestore.instance.collection("players").doc('doc-id2');

    final player = {'name': name, 'age': "25", 'country': 'N/A', "club": ""};

    docUser.set(player);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Demo'),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Name'),
                  controller: controller,
                ),
              ),
              TextButton(
                  onPressed: () {
                    final name = controller.text;

                    addPlayer(name: name);
                  },
                  child: const Text('Save', style: TextStyle(fontSize: 18)))
            ],
          ),
        ));
  }
}
