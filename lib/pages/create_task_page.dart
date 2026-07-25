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

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final titleController = TextEditingController();
  final budgetController = TextEditingController();
  final locationController = TextEditingController();
  final discriptionController = TextEditingController();
  List<XFile>? images = [];
  List<File> selectedimages = [];
  List<String> imageUrls = [];
  int num = -1;
  bool uploadingImages = true;
  String imagebutton = 'Add Images';
  String errorTitle = "";
  String errorMessage = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4cc485),
      body: SingleChildScrollView(
        
        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50,),
                          child: Text("Create New Task",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                           ) ,),
                        ),
        
                        Padding(
                      padding: const EdgeInsets.only(left: 80, right: 80, top: 0,),
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter> [
                            LengthLimitingTextInputFormatter(5),
                            FilteringTextInputFormatter.digitsOnly,
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
                        
                        images = await
                        ImagePicker().pickMultiImage(imageQuality: 50, limit: 5, maxHeight: 512, maxWidth: 512,);

                         setState(() {
                          if (images!.isNotEmpty)
                          {
                            imagebutton = 'Change Image';
                            selectedimages = images!.map((xFile) => File(xFile.path)).toList();
                          }
                            
                         });
                          
                        
        
                       
        
        
                    
                         
                      
                         
                      
                   }, 
                    
                    
                    child: Text(imagebutton)),
                  
                   selectedimages.isEmpty
                    ? Text("")
                    :Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: GridView.builder(
                        itemCount: selectedimages.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          ),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(selectedimages[index], fit: BoxFit.cover,)
                            
                            
                            );
                        
                        }
                        
                          
                          ),
                      ),
                    ),
                    
                
        
                  uploadingImages
                
                  ?ElevatedButton(
                  child: Text("Post Task!"),
                  onPressed: 
                  
                  () async
          {       
            
                  if (titleController.text == "")
                  {
                    errorTitle = "Title Required";
                    errorMessage = "Please provide a title for the task!";
                    print(errorTitle + errorMessage);
                  }
                  else if (budgetController.text == "")
                  {
                    errorTitle = "Budget Required";
                    errorMessage = "Please provide a budget for the task!";
                    print(errorTitle + errorMessage);
                  }
                  else if (locationController.text == "")
                  {
                      errorTitle = "Location Required";
                      errorMessage = "Please provide a location for the task!";
                      print(errorTitle + errorMessage);
                  }
                  else if (discriptionController.text == "")
                  {
                      errorTitle = "Discription Required";
                      errorMessage = "Please provide a discription for the task!";
                      print(errorTitle + errorMessage);
                  }
                  else if (images!.isEmpty)
                  {
                      errorTitle = "Image Required";
                      errorMessage = "Please provide an image for the task!";
                      print(errorTitle + errorMessage);
                  }
                  else {
                
                
        
                 if (images!.isNotEmpty) {
                       // profileImage = File(image.path);
                      
                       setState(() {
                          uploadingImages = false;
        
                       });
              
                          
                          String reference = '${titleController.text}_${DateTime.now().millisecondsSinceEpoch}';
                         
        
                          
        
                          for (var image in images!)
                          {
                            
                            num++;
        
                            
                            final storageRef = FirebaseStorage.instance.ref().child('users/$uid/tasks/$reference/task_picture_${DateTime.now().millisecondsSinceEpoch}');
                            await storageRef.putFile(File(image.path));
                            String url = await storageRef.getDownloadURL();
                            imageUrls.add(url);
                         
        
                           
                            
                          }
        
                          images = List.empty();
        
                        }
                
                       
        
        
                 db
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
                  Navigator.pop(context);
                  titleController.clear();
                  budgetController.clear();
                  locationController.clear();
                  discriptionController.clear();
                  imageUrls.clear();
              }
              
          }
              
            
            
            )
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Container(
                child: Row
                (children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text("Uploading Task... Please Wait!"),
                    ),
                  ),
                   const CircularProgressIndicator(),
                              
                              
                ],),
              ),
            ),
            
            
            
            
        
        
                      ],
                      
                    ),
      ),


    );
  }
}