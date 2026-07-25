import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Text("Welcome to Taskerr Admin Page!"),


          ElevatedButton(
                onPressed: () async {
                await FirebaseAuth.instance.signOut();
                }, 
                child: Text("Logout")),


        ],

      ),
    );
  }
}