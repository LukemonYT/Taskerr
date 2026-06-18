import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    List<Widget> pages = [
     
      ProfilePage(),
    ];


  @override
  Widget build(BuildContext context) {
    return Scaffold();   
      
  }
  
}
