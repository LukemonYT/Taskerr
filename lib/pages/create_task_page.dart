
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskerr/pages/login_page.dart';
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
  List<XFile>? pickedImages = [];
  List<XFile>? selectedImages = [];
 
  List<String> imageUrls = [];
  int num = -1;
  bool uploadingImages = true;
  String imagebutton = 'Add Images (6 Max)';
  



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
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10,),
                              child: Text("Create New A Task",
                               style: TextStyle(
                                
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                               ) ,),
                            ),
        
                            Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40, top: 10,),
                        
                        child: Text('Post your task and find your freelancer now!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                         // fontWeight: FontWeight.bold,
                          color: Colors.white,
        
                        ),
                        ),
                      ),
            
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
                            maxLines: 10,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Description:\nInclude details such as, Date, Time, Duration, Equipment Needed/Provided, Requirements and Additional Information.',
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
                        Padding(
                          padding: const EdgeInsets.only(top: 30,),
                          child: ElevatedButton(
                            onPressed: () async {
                              
                              pickedImages = await
                              ImagePicker().pickMultiImage(imageQuality: 50, limit: 6, maxHeight: 512, maxWidth: 512,);
                               selectedImages = pickedImages!.take(6).toList();

                               setState(() {
                                if (selectedImages!.isNotEmpty)
                                {
                                  imagebutton = 'Change Images';
                                }
                                  
                               });
                                
                              
                                  
                             
                                  
                                  
                          
                               
                            
                               
                            
                                             }, 
                          
                          
                          child: Text(imagebutton,
                          style: TextStyle(
                            color: Colors.black,
                          ),)),
                        ),
                      
                       selectedImages!.isEmpty
                        ? Text("")
                        :Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                          itemCount: selectedImages!.length,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                            ),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(selectedImages![index].path, fit: BoxFit.cover,)
                              
                              
                              );
                          
                          }
                          
                            
                            ),
                        ),
                        
                       selectedImages!.isEmpty
                       ? Container()
            
                      :uploadingImages
                        
                      ?Container(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: ElevatedButton(
                          child: Text("Post Task!",
                          style: TextStyle(
                            color: Colors.black,
                          ),),
                          onPressed: 
                          
                          () async
                                    {       
                                      
                          if (titleController.text == "")
                          {
                            showErrorBox(context, "Title Required", "Please provide a title for the task");
                          }
                          else if (budgetController.text == "")
                          {
                            showErrorBox(context, "Budget Required", "Please provide a budget for the task!");
                          }
                          else if (locationController.text == "")
                          {
                            showErrorBox(context, "Location Required", "Please provide a location for the task!");
                          }
                          else if (discriptionController.text == "")
                          {
                            showErrorBox(context, "Discription Required", "Please provide a discription for the task!");
                          }
                          else if (selectedImages!.isEmpty)
                          {
                            showErrorBox(context, "Image Required", "Please provide an image for the task!");  
                          }
                          else {
                            
                               setState(() {
                                  uploadingImages = false;
                                  
                               });
                                        
                                  
                              String reference = '${titleController.text}_${DateTime.now().millisecondsSinceEpoch}';
                                 
                                  
                                  
                                  
                                  for (var image in selectedImages!)
                                  {
                                    
                                    num++;
                                  
                                    Uint8List imageData = await image.readAsBytes();
                          
                                    final storageRef = FirebaseStorage.instance.ref().child('users/$uid/tasks/$reference/task_picture_${DateTime.now().millisecondsSinceEpoch}');
                                    await storageRef.putData(imageData);
                                    String url = await storageRef.getDownloadURL();
                                    imageUrls.add(url);
                                 
                                  
                                   
                                    
                                  }
                                  
                                  selectedImages = List.empty();
                                  
                                
                                          
                               
                           
                                  
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
                           'createdAt': DateTime.now().millisecondsSinceEpoch,
                           'isApproved': false,
                           'uid': uid,
                           'displayName': user.displayName,
                          });
                                          
                          
                            
                                       
                          
                                           
                          
                          
                          
                          
                          
                          
                          
                          Navigator.pop(context);
                          titleController.clear();
                          budgetController.clear();
                          locationController.clear();
                          discriptionController.clear();
                          imageUrls.clear();
                                        }
                                        
                                    }
                                        
                                      
                                      
                                      ),
                        ),
                      )
                :             
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 30,),
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
                        child: Row(children: [
                          Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text("Uploading Task... Please Wait!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                          ),
                        ),
                      ),
                       const CircularProgressIndicator(color: Colors.white,),
                        ],)
        
        
        
                      )))))
        
                
                
                
            
                          
                          ],
                          
                        ),
          ),
        
        
        ),
      ),
    );
  }
}

void showErrorBox(BuildContext context, String errorTitle, String errorMessage) {
    showDialog(context: context, builder: (BuildContext context) 
    {
      return AlertDialog(
        backgroundColor: Color(0xFF4cc485),
        title: Text(errorTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight(600)
        ),
        ),
        content: Text(errorMessage,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,

        ),
        ),
        actions: [
          ElevatedButton(
            onPressed: Navigator.of(context).pop,
             child: Text("Okay",
             style: TextStyle(
             color: Colors.black
            ),
          ))
        ],
      );
    }
    
    
    );
  }