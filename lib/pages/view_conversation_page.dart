

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:taskerr/pages/profile_page.dart';

class ViewConversationPage extends StatefulWidget {
  final String chatId;
 
  final String otherDisplayName;

  const ViewConversationPage({super.key, required this.chatId, required this.otherDisplayName, });

  @override
  State<ViewConversationPage> createState() => _ViewConversationPageState();
}

final messageController = TextEditingController();
String displayName = '';

class _ViewConversationPageState extends State<ViewConversationPage> {
  
  @override
  Widget build(BuildContext context) {
     final chatRef = FirebaseFirestore.instance.collection('chats');
    
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 600,
        ),
        child: Scaffold(
          
          appBar: AppBar(
            backgroundColor: Color(0xFF4cc485),
            leading: BackButton(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF4cc485),
          body: Column(
              
            children: [
              
        
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: chatRef
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('sentAt', descending: false)
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
                         if (data.docs[index]['senderId'] != FirebaseAuth.instance.currentUser!.uid){
                            displayName = widget.otherDisplayName;
                         }
                         else {
                           displayName = "${FirebaseAuth.instance.currentUser!.displayName}";
                         }
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5,),
                          child: SizedBox(
                            width: 100,
                            child: ListTile(
                            
                              
                              tileColor: Color(0xFF43B07A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),

                              title: Text(data.docs[index]['text'], 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),),
                            
                              subtitle: Row(children: [Icon(Icons.person, color: Colors.white,), Expanded(
                                child: Text(displayName, 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                  ),),
                              ),],),
                            
                                
                             
                              
                            ),
                          ),
                        );
                      });
                   }
                   
                   
                   )
        
        
              ),
        
             
        
        
                   Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 25),
                        child: TextField(
                          controller: messageController,
                     
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          style: TextStyle(
                            fontSize: 13,
                            
                            
                          ),
                          
                          
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Message:',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send_rounded, color: Colors.grey,),
                              onPressed: () async {
                              await chatRef.doc(widget.chatId).collection('messages').add({
                                'senderId': uid,
                                'text': messageController.text,
                                'sentAt': DateTime.now().millisecondsSinceEpoch,
                                'read': false,
                          
                              });
        
                              await chatRef.doc(widget.chatId).update({
                                'lastMessage': messageController.text,
                                'lastSentAt': DateTime.now().millisecondsSinceEpoch,
                                'lastSender': user.displayName,
                              });
        
                              messageController.clear();
                            },
                              
                            
                            ),
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
            ]
          )
        ),
      ),
    );
  }
}