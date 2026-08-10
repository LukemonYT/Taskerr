
import 'package:flutter/material.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:taskerr/pages/view_task_page.dart';

class ViewProfilePage extends StatefulWidget {
   final String displayName;
   final String bio;
   final String profileImageURL;

  const ViewProfilePage({super.key, required this.displayName, required this.bio, required this.profileImageURL});

 

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

String title = 'Help & Info';
String message = "For support or bug reports email: taskerrchb@gmail.com\n Terms & Conditions\nThe app's purpose is to connect users only;\nUsers are responsible for making their own arrangements regarding the job;\n Users are responsible for their own actions and conduct;\nThe app is not responsible for the quality of work completed or disputes between users;\nUsers must follow the law and carry out work safely; and\n The app can suspend or remove users who misuse the platform.";

class _ViewProfilePageState extends State<ViewProfilePage> {
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
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
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
                          imageUrl: widget.profileImageURL,
                          errorBuilder: (context, url, error) => Image.asset('assets/images/blank_profile.png'),
                        ),
                        ),
                      ),
                  ),
                    Text(widget.displayName, style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.white),),
                    
                  
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
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
                    
                    
                      child: Center(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
                        child: Column(
                          children: [
                            Text("Bio:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900
                              
                            ),),
                            
                            Text(bio,
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
        
        
        
        
        
                ],
              ),
            ),
          ),
        
        ),
      ),
    );
  }
}

