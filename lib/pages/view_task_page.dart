

import 'package:flutter/material.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:taskerr/pages/create_task_page.dart';
import 'package:taskerr/pages/messages_page.dart';
import 'package:taskerr/pages/navigation_page.dart';
import 'package:taskerr/pages/profile_page.dart';
import 'package:taskerr/pages/view_conversation_page.dart';
import 'package:taskerr/pages/view_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_user_service.dart';



class ViewTaskPage extends StatefulWidget {

  
  final String title;
  final String budget;
  final String location;
  final String description;
  final List<dynamic> images;
  final String uid;
  final String displayName;


  const ViewTaskPage({super.key, required this.title, required this.budget, required this.location, required this.description, required this.images, required this.uid, required this.displayName});

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

String url = "";
String bio = "";


class _ViewTaskPageState extends State<ViewTaskPage> {
  @override
  @override
  void initState() {
    super.initState();
    getUserData();
    
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
                            Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 5),
                              borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(100),
                                child: CachedNetworkImage(
                                
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF4cc485),),),
                                imageUrl: url,
                                errorBuilder: (context, url, error) => Image.asset('assets/images/blank_profile.png'),
                              ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
        
                                 
                                  GestureDetector(
                                    child: Text(widget.displayName,
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900
                                      
                                    ),
                                    
                                    ),
        
                                    onTap: () {
                                      if (bio == 'null'){
                                        bio ='No Bio';
                                      }
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePage(
                                        displayName: widget.displayName,
                                        bio: bio,
                                        profileImageURL: url,
                                      ) ));
                                    },
                                  ),
                                  
                                 // Icon(Icons.star, color: Colors.amber,)
                                 
                                ],
                              ),
                            ),
        
                            uid != widget.uid
                            
                             ? Expanded(
                              child: ElevatedButton(
                                onPressed: () async { 
                                  
                                  final uid = FirebaseAuth.instance.currentUser!.uid;
                                  List<String> ids = [uid, widget.uid];
                                  ids.sort();
                                  String chatId = ids.join("_");
                                  chatId = chatId + "_${widget.title}";
        
                                  final chatRef = FirebaseFirestore.instance.collection('chats')
                                  .doc(chatId);
                                  final snapshot = await chatRef.get();
        
                                  if (!snapshot.exists){
                                    await chatRef.set({
                                      'jobTitle': widget.title,
                                      'participants': [user.displayName, widget.displayName],
                                      'participantIds': [uid, widget.uid],
                                      'lastTimestamp': FieldValue.serverTimestamp(),
                                      'lastMessage': 'Send the first message',
                                      'lastSender': 'Msg',
        
                                      'participantInfo':{
                                        widget.uid: {
                                          'displayName': widget.displayName,
                                        },
                                        uid: {
                                          'displayName': FirebaseAuth.instance.currentUser!.displayName,
                                        }
        
                                      },
                                        
                                       
                                    });
                                  }
        
                                  
                                  
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewConversationPage(
                                    chatId: chatId,
                                    otherDisplayName: widget.displayName,
                                  
                                    
                                    ))); },
                                child: Text("💬 Message",
                                
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                
                                )),
                            )
                            : Container(),
                            
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


  Future getUserData() async {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
        if (doc.exists && doc.data() != null){
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          setState(() {
             url = data['profileImageURL'].toString();
             bio = data['bio'].toString();
          });
          
          
        

  }

}
 catch (e) {

}
}
}

int getCrossAxisCount (int totalImages){
  if (totalImages == 1){
    return 1;
  }
  else {
    return 2;
  }

}



