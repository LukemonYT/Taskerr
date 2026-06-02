import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color(0xFF4cc485),
        title: Center(
          child: SizedBox(
            height: 60,
            child: Image.asset(
                          'assets/images/taskerr_logo_white.png', fit: BoxFit.contain,
                        ),
          ),
        ),
      ),



      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFF4cc485),
        showUnselectedLabels: true,
      
        items: [

        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
       
          label: 'Explore',
          
          
          
          ),

        BottomNavigationBarItem(
          icon: Icon(Icons.backpack),
         
          label: 'My Tasks',
          
          ),

        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
          ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
          ),







      ]) ,

      body: Center(
        child: ListView(
          
          

        ),



      ),


    );
    
  }
}