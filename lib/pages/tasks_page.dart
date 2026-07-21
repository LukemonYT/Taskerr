import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskerr/pages/profile_page.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final titleController = TextEditingController();
  final budgetController = TextEditingController();
  final locationController = TextEditingController();
  final discriptionController = TextEditingController();
  List<XFile>? images = List.empty();
  List<String> imageUrls = [];
  int num = -1;
  bool uploadingImages = false;
  



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

                        leading: Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey,),

                          borderRadius: BorderRadius.circular(100),
                          
                        
                          ),
                          
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            
                          child: CachedNetworkImage(
                            
                            height: 100,
                            width: 64,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2,),),
                            imageUrl: "https://logsonline.co.uk/media/magefan_blog/kiln_dried_firewood.jpg",
                            errorBuilder: (context, url, error) => Image.asset('assets/images/blank_profile.png'),
                          
                          ),
                          ),
                        ),




                        title: Text(data.docs[index]['title'], 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),),

                        subtitle: Row(children: [Icon(Icons.location_on, color: Colors.white,), Text(" " + data.docs[index]['location'], 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                          ),),],),

                          
                          
                        trailing: Text("\$" + data.docs[index]['budget'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                        ),
                        
                      ),
                    );
                  });
               }
               
               
               )


          ),

          FloatingActionButton(
            backgroundColor: Color(0xFF4cc485),
            onPressed: () {
            showModalBottomSheet(
              context: context,
               builder: (context){
                return Container(
                  child:  Column(
                    children: [
                      Text("Create New Task"),

                      Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 30,),
                    child: TextField(

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30)
                      ],
                      controller: titleController,
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Title:',
                        
                      //  prefixIcon: Icon(Icons.title, color: Colors.grey,),
                        
                        hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        ),
                        
              
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        )

                      ),
          
                    ),

                    
                    
                  ),

                   Row(
                    children: [
                      Expanded(
                        child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 10, top: 30,),

                        child: TextField(
                        
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5)
                        ],
                        controller: budgetController,
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Budget:',
                          
                          prefixIcon: Icon(Icons.attach_money_rounded, color: Colors.grey,),
                          
                          hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          ),
                          
                                      
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          )
                        
                        ),
                                  
                                            ),
                        
                                            
                                            
                                          ),
                      ),
                  
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 40, top: 30,),
                      child: TextField(
                    
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20)
                        ],
                        controller: locationController,
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Location (Town):',
                          
                        //  prefixIcon: Icon(Icons.title, color: Colors.grey,),
                          
                          hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          ),
                          
                                  
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          )
                    
                        ),
                              
                      ),
                    
                      
                      
                    ),
                  ),

                    ],


                   ),

                      Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 30,),
                    child: TextField(

                      controller: discriptionController,
                      maxLines: 4,
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Description:\nInclude details such as,',
                       // prefixIcon: Icon(Icons.text_fields, color: Colors.grey,),
                        
                        hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        ),
                        
              
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        )

                      ),
          
                    ),
                    
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      
                     final images = await
                      ImagePicker().pickMultiImage(imageQuality: 50, limit: 5,);
                      

                     


                  
                       
                    
                       
                    
                 }, 
                  
                  
                  child: Text("Add Pictures")),


                  


                    ElevatedButton(
                    child: Text("Post Task!"),
                    onPressed: uploadingImages
                    ? null
                    :() async
            { 
              
               if (images != null){
                     // profileImage = File(image.path);
                        
                        String reference = '${titleController.text}_${DateTime.now().millisecondsSinceEpoch}';

                        

                        for (var image in images!)
                        {
                          
                          num++;

                          
                          final storageRef = FirebaseStorage.instance.ref().child('users/$uid/tasks/$reference/task_picture_${DateTime.now().millisecondsSinceEpoch}');
                          await storageRef.putFile(File(image.path));
                          String url = await storageRef.getDownloadURL();
                          imageUrls.add(url);

                         
                          
                        }

                      

                      }
              
                     


               await db
              .collection('users')
              .doc(user.uid)
              .collection("tasks")
              .add(
                {
                 'title': titleController.text,
                 'budget': budgetController.text,
                 'location': locationController.text,
                 'description': discriptionController.text,
                 'imageUrls': imageUrls,
                }
                
                
                );
                titleController.clear();
                budgetController.clear();
                locationController.clear();
                discriptionController.clear();
                imageUrls.clear();
                Navigator.pop(context);
            }
            
            
          
          
          )
          
          
          


                    ],
                  ),
                );
               });


          }, 
          
          child: Icon(Icons.add, color: Colors.white,) ,),


          
        ],

        
      ),
      
      
    );
  }
}