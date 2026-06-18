
import 'package:flutter/material.dart';
import 'package:taskerr/pages/explore_page.dart';
import 'package:taskerr/pages/login_page.dart';
import 'package:taskerr/pages/messages_page.dart';
import 'package:taskerr/pages/profile_page.dart';
import 'package:taskerr/pages/tasks_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
 
    int _currentIndex = 0;


   final List<Widget> _pages = const [
     ExplorePage(),
     TasksPage(),
     MessagesPage(),
     ProfilePage(),
  ];
 
  

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
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFF4cc485),
        showUnselectedLabels: true,
      
        items: const [

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

      body: IndexedStack(

        index: _currentIndex,
        children: _pages,
       //  child: ListView(


      ),
        
       
          
          

        



    //  ),


    );
    
  }
}