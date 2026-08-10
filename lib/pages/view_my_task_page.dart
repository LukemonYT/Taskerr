

import 'package:flutter/material.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:taskerr/admin_page.dart';
import 'package:taskerr/pages/create_task_page.dart';
import 'package:taskerr/pages/messages_page.dart';
import 'package:taskerr/pages/navigation_page.dart';
import 'package:taskerr/pages/profile_page.dart';
import 'package:taskerr/pages/tasks_page.dart';
import 'package:taskerr/pages/view_conversation_page.dart';
import 'package:taskerr/pages/view_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_user_service.dart';



class ViewMyTaskPage extends StatefulWidget {

  
  final String title;
  final String budget;
  final String location;
  final String description;
  final List<dynamic> images;
  final String id;
  final bool isApproved;


  const ViewMyTaskPage({super.key, required this.title, required this.budget, required this.location, required this.description, required this.images, required this.id, required this.isApproved});

  @override
  State<ViewMyTaskPage> createState() => _ViewMyTaskPageState();
}

String url = "";
String bio = "";


class _ViewMyTaskPageState extends State<ViewMyTaskPage> {
  @override
  @override
  void initState() {
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: Scaffold(
        
          appBar: AppBar(
            backgroundColor: Color(0xFF4cc485),
            leading: BackButton(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF4cc485),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                          
                            child: GridView.builder(
                            itemCount: widget.images.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: getCrossAxisCount(widget.images.length),
                              childAspectRatio: 16/9,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            
                              ),
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(widget.images[index], fit: BoxFit.cover,)
                                
                                
                                
                                );
                            
                            }
                            
                              
                              ),
                          
                        ),
        
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 20, right: 50,),
                  child: Text(widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900
                  
                  ),
                  ),
                ),
        
                Row(children: [
                  Expanded(
                    child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 0),
                    child: Row(children: [Icon(Icons.location_on, color: Colors.white,), Expanded(
                        child: Text(widget.location, 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700
                          ),),
                      ),],),
                    ),
                  ),
        
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30,),
                      child: Text(widget.budget,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w900
                      
                      ),
                      ),
                    ),
                  ),
        
                ],),
        
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF43B07A),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 10,
                            blurRadius: 15,
                            offset: const Offset(10, 10)
                          )
                        ]
                      ),
                    
                    
                      child: Center(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
                        child: Column(
                          children: [
                            Text("Description:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900
                              
                            ),),
                            
                            Text(widget.description,
                              style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                        ),
                        ),
        
        
                          ],
                        )
                        
                        
                        
                      )),),
                  ),
                ),
        
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF43B07A),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 10,
                            blurRadius: 15,
                            offset: const Offset(10, 10)
                          )
                        ]
                      ),
                    
                    
                      child: Center(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15,),
                        child: Row(
                          children: [
                            widget.isApproved
                            ? Expanded(
                              child: Text("Approval Status: Task is Approved!",
                              style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                                                    ),
                              ),
                            )
                            :
                            Expanded(
                              child: Text("Approval Status: Task waiting for Approval! \n(This will take up to 12 hours)",
                              style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                                                    ),
                              ),
                            ),
        
        
                          ElevatedButton(
                           style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffDC3545),
                           ),
                           onPressed: () async {
                            FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .collection("tasks")
                            .doc(widget.id).delete();
                            Navigator.pop(context);
                           },
                           child: Text("Delete Task",
                           style: TextStyle(
                            color: Colors.white,
                           ),
                          
                           ),
                          
                          )
                            
                          ],
        
                        ),
        
                        
                        
                        
                        
                      )),),
                  ),
                ),
              ],
        
            ),
          ),
        ),
      ),
    );
  }



          
        

  

int getCrossAxisCount (int totalImages){
  if (totalImages == 1){
    return 1;
  }
  else{
    return 2;
  }
 
}

}