import 'dart:async';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_user_service.dart';

final db = FirebaseFirestore.instance;
bool isEditingBio = false;
final bioController = TextEditingController();
final emailResetController = TextEditingController();



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

XFile? profileImage;
String uid = FirebaseAuth.instance.currentUser!.uid;
String url = '';
String dataType = "";
String Aurl = '';

final UserService userService = UserService();
 final focusNode = FocusNode();


    final user = FirebaseAuth.instance.currentUser!;


class _ProfilePageState extends State<ProfilePage> {

  
  @override
   void initState() {
     super.initState;
     getUserData();
      

     
     
      
     }
    
   
      

    
     

   
  


  @override
  Widget build(BuildContext context) {

    

   
   

    return Scaffold(
      backgroundColor: Color(0xFF4cc485),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Stack(
              alignment: Alignment.bottomRight,
              children:[
                Padding(
                  padding: const EdgeInsets.only(top: 30,),
                  child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 7),
                  
                  borderRadius: BorderRadius.circular(120),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(100),
                    child: CachedNetworkImage(
                    
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,),),
                    imageUrl: Aurl,
                    errorBuilder: (context, url, error) => Image.asset('assets/images/blank_profile.png'),
                  ),
                  ),
                                ),
                ),
              Positioned(
                bottom: 10,
                right: 10,
                child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: IconButton(onPressed: () async {
                
                  try{
                    
                  final image = await
                ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
                  if (image != null){
                    Uint8List imageData = await image.readAsBytes();
                    final storageRef = FirebaseStorage.instance.ref().child('users/$uid/profile_picture.jpg');
                  await storageRef.putData(imageData);
                  url = await storageRef.getDownloadURL();
                  
                  await db.collection('users').doc(user.uid).set({
                    
                    'profileImageURL': url
                  });
                  setState(() {
        
                    getUserData();
                  });
                  }
                   
                   
                  
                  }
                  catch (e){
                    print("error");
                  }
        
                }, icon: Icon(Icons.edit, color: Color(0xFF4cc485),)),
              ))
          ]),
        
        
        
              Text(user.displayName.toString(), style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.white),),
              Text(user.email.toString(),
               style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white
               ) ,  ),
        
             
        
            
              
        
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                   Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 30,),
                    child: TextField(
                      minLines: 10,
                      maxLines: 10,
                      controller: bioController,
                      focusNode: focusNode,
                      enabled: isEditingBio,
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Bio:',
                        
                        
                        
                        
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
        
                    Positioned(
                      bottom: 5,
                      right: 45,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF4cc485),
                        radius: 22,
                        child: IconButton(
                          onPressed: () async {
        
                             setState(() {  
                              isEditingBio = !isEditingBio;
                            });
        
                            WidgetsBinding.instance.addPostFrameCallback((_){
                              if (isEditingBio) {
                                focusNode.requestFocus();
                              }
                              else {
                                focusNode.unfocus();
                              }
                            });
                            
                            if (isEditingBio == false){
                              FirebaseFirestore.instance.collection('users').doc(uid).update({'bio': bioController.text});
                            }
                           
                            
        
                          },
                           icon: Icon(isEditingBio ? Icons.check: Icons.edit, color: Colors.white,)),
        
                    ))
        
        
        
                    
          ]),
        
           Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                onPressed: () {
                  showErrorBox(context);}, 
                child: Text("Help & Information",
                style: TextStyle(
                  color: Colors.black,
                ),
                ))),
           
        
           Row(
            children: [
               Expanded(
                 child: Padding(
                  padding: const EdgeInsets.only(top: 120, left: 10, right: 10, bottom: 30),
                  child: ElevatedButton(
                  onPressed: () {
                    showResetBox(context, emailResetController);
                  
                  }, 
                  child: Text("Reset Password",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  ))),
               ),
        
                Expanded(
                  child: Padding(
                  padding: const EdgeInsets.only(top: 120, left: 10, right: 10, bottom: 30,),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffDC3545),
                    ),
                  onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  
                  }, 
                  child: Text("Logout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ))),
                ),
            ],
        
           )
          ],
        
        ),

      ),
        );

    
  }
  
   
    Future getUserData() async {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (doc.exists && doc.data() != null){
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          setState(() {
             Aurl = data['profileImageURL'].toString();
            
            if (data['bio'] != null)
            {
              bioController.text = data['bio'].toString();
            }
           
          });
          
          
        

  }

}
 catch (e) {

}
}




   }

void showResetBox(BuildContext context, final emailResetController,)
{
  showModalBottomSheet(context: context, isScrollControlled: true, builder: (BuildContext context)
  
  {
    
    return Container(
     height: MediaQuery.of(context).size.height * 0.75,
     
      decoration: BoxDecoration(
        color: Color(0xFF4cc485),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          )),
      
      
      child: Column(children: [

        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 45),
          child: Text('Forgot Your Password?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight(1000),
                     // fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),
          
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
          child: Text('Reset your password here to get back to your freelance opportunities!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                     // fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),
          
          ),
        ),

        Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 30,),
                    child: TextField(

                      controller: emailResetController,

                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Confirm Your Reset Email:',
                        prefixIcon: Icon(Icons.email, color: Colors.grey,),
                        
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
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 20,),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (emailResetController.text == user.email){
                       try {
                        await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                          email: emailResetController.text, );
                          emailResetController.clear();
                          Navigator.pop(context);
                       }
                       catch (e) 
                       {
                        if (e.toString() == "[firebase_auth/invalid-email] The email address is badly formatted.")
                         print("Please check email");
                        
                        else (print(""));
                       };
                        }
                        


                      } ,
                      child: const Text ("Reset Password"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      

                      
                    ),
                  ),










      ],),

    );
      
    
  }
  
  
  );

  



}

void showErrorBox(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) 
    {
      return AlertDialog(
        backgroundColor: Color(0xFF4cc485),
        title: Text('Help & Info',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight(600)
        ),
        ),
        content: Text("For support or bug reports email:\ntaskerrchb@gmail.com\n\nTerms & Conditions:\nThe app's purpose is to connect users only;\nUsers are responsible for making their own arrangements regarding the job;\nUsers are responsible for their own actions and conduct;\nThe app is not responsible for the quality of work completed or disputes between users;\nUsers must follow the law and carry out work safely; and\nThe app can suspend or remove users who misuse the platform."
,
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



