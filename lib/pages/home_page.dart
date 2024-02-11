import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'add_members_page.dart';
import 'login_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final query = FirebaseDatabase.instance.ref("members");
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMembers()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          title: const Text("Firebase"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: FirebaseAnimatedList(
            query: query,
            itemBuilder: (context, snapshot, animation, index) {
              return ListTile(
                title: Text(snapshot.child("name").value.toString()),
                leading: Text(snapshot.child("id").value.toString()),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    query.child(snapshot.child("id").value.toString()).update({"name": nameController.text});
                                    nameController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Update"),
                                )
                              ],
                              content: TextField(controller: nameController),
                            ),
                          );
                        },
                        leading: const Icon(Icons.edit),
                        title: const Text("Edit"),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          query.child(snapshot.child("id").value.toString()).remove();
                        },
                        leading: const Icon(Icons.delete),
                        title: const Text("Delete"),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
