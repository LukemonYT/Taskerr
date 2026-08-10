import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:taskerr/admin_page.dart';
import 'package:taskerr/pages/profile_page.dart';
import 'view_task_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePage();
}

class _ExplorePage extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(

      body: Column(
          
        children: [
          

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
              .collectionGroup('tasks')
              .where('isApproved', isEqualTo: true)
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
                  return Center(child: CircularProgressIndicator(color: Color(0xFF4cc485),),);
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ViewTaskPage(
                            title: data.docs[index]['title'],
                            budget: "\$" + data.docs[index]['budget'],
                            location:" " + data.docs[index]['location'],
                            description: data.docs[index]['description'],
                            images: data.docs[index]['imageUrls'],
                            uid: data.docs[index]['uid'],
                            displayName: data.docs[index]['displayName'],
                            )));
                        }
                        
                      ),
                    );
                  });
               }
               
               
               )


          ),

         
              
        ]
      )
    );

          


      
    
  }
}