import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePage();
}

class _ExplorePage extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(   

          child: ElevatedButton(
          onPressed: () async {
           await FirebaseAuth.instance.signOut();


          }, 
          child: Text("Logout")),
),
    );

      
    
  }
}