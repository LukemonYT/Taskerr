import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

void testStorageConnection() {
  // Access your default Cloud Storage bucket instance
  final storageRef = FirebaseStorage.instance.ref();
  
  // Create a child reference path for testing
  final testRef = storageRef.child("test/hello.txt");
  
  print("Firebase Storage path initialized: ${testRef.fullPath}");
}





class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
File? profileImage;
String url = "";
String uid = FirebaseAuth.instance.currentUser!.uid;


    final user = FirebaseAuth.instance.currentUser!;


class _ProfilePageState extends State<ProfilePage> {

  
  



  @override
  Widget build(BuildContext context) {

   
   

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey,),

                borderRadius: BorderRadius.circular(100),
                
               
                ),
                
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(100),
                   
                 child: CachedNetworkImage(
                  
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2,),),
                  imageUrl: url,
                  errorBuilder: (context, url, error) => Image.asset('assets/images/blank_profile.png'),
                
                ),
                ),
              ),



                Text(user.displayName.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight(800)),),
                Text(user.email.toString(), ),
          
              
              
              Padding(
                padding: const EdgeInsets.all(100.0),
                child: ElevatedButton(
                 onPressed:() async {
                  final image = await
                  ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
                    if (image != null){
                      profileImage = File(image.path);
                    }
                    final storageRef = FirebaseStorage.instance.ref().child('users/$uid/profile_picture.jpg');
                    await storageRef.putFile(profileImage!);
                    url = await storageRef.getDownloadURL();
                    
                    await db.collection('users').doc(user.uid).set({
                      
                      'profileImageURL': url
                    });
      
            

                    setState(() {

                      
                    });
                 }
            
                  
                  
                 , child: Text("Pick"),
                  style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                 ),),
              ),

              
                ElevatedButton(
                onPressed: () async {
                await FirebaseAuth.instance.signOut();
                
                }, 
                child: Text("Logout")),
              
          
            ],
          
          ),
        ),

      ),
        );

    
  }
  
   
}

