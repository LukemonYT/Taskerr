

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskerr/pages/create_task_page.dart';
import 'package:taskerr/pages/profile_page.dart';
import 'package:taskerr/pages/view_my_task_page.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
          
        children: [
          

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: db
              .collection('users')
              .doc(user.uid)
              .collection("tasks")
              .orderBy('createdAt', descending: true)
              .snapshots()
              ,
              builder:
               (
                  BuildContext context, 
                  AsyncSnapshot<QuerySnapshot> snapshot,
               ) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                }
                final data = snapshot.requireData;
                return ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ListTile(

                        
                        tileColor: Color(0xFF4cc485),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                        
                        leading: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            
                          child: CachedNetworkImage(
                            
                            height: 100,
                            width: 64,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,),),
                            imageUrl: data.docs[index]['imageUrls'][0],
                            errorBuilder: (context, url, error) => Image.asset('assets/images/blank_profile.png'),
                          
                          
                          ),
                        ),




                        title: Text(data.docs[index]['title'], 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),),

                        subtitle: Row(children: [Icon(Icons.location_on, color: Colors.white,), Expanded(
                          child: Text(" " + data.docs[index]['location'], 
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                            ),),
                        ),],),

                          
                          
                        trailing: Text("\$" + data.docs[index]['budget'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMyTaskPage(
                            title: data.docs[index]['title'],
                            budget: data.docs[index]['budget'],
                            location: data.docs[index]['location'],
                            description: data.docs[index]['description'],
                            images: data.docs[index]['imageUrls'],
                            id: data.docs[index].id,
                            isApproved: data.docs[index]['isApproved'],
                            ) ));
                        },
                        
                      ),
                    );
                  });
               }
               
               
               )


          ),

          Align(
            alignment: AlignmentGeometry.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 20,),
              child: FloatingActionButton(
                backgroundColor: Color(0xFF43B07A),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskPage()));
                },
              
              child: Icon(Icons.add, color: Colors.white,) ,),
            ),
          ),


          
        ],

        
      ),
      
      
    );
  }
}