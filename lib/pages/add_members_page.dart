import 'package:firebase/widgets/my_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({super.key});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  final TextEditingController memberController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.ref("members");
  @override
  void dispose() {
    memberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextFormField(
              controller: memberController,
              decoration: const InputDecoration(labelText: "Member Name"),
            ),
            const SizedBox(height: 30),
            MyButton(
              onPressed: () {
                final String currentTime = DateTime.now().millisecond.toString();
                dbRef.child(currentTime).set({
                  "id": currentTime,
                  "name": memberController.text,
                });
              },
              text: "ADD",
            ),
          ],
        ),
      ),
    );
  }
}
