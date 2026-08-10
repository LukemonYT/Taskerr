import 'package:flutter/material.dart';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskerr/pages/profile_page.dart';
import 'package:taskerr/pages/view_conversation_page.dart';

class MessagesPage extends StatefulWidget {
  
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPage();
}

String profileImageURL = '';


class _MessagesPage extends State<MessagesPage> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
              .collection('chats')
              .where('participantIds', arrayContains: FirebaseAuth.instance.currentUser!.uid)
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
      
              
      
                {}
                return ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    
                    final participantsIds = List<String>.from(data.docs[index]['participantIds']);
                    final otherUid = participantsIds.firstWhere(
                      (uid) => uid != FirebaseAuth.instance.currentUser!.uid,
                    );
                    final displayName = data.docs[index]['participantInfo'][otherUid]['displayName'];
                    
                     
                    
                    
                    
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ListTile(
                        
      
                        
                        tileColor: Color(0xFF4cc485),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      
                        
                        leading: FutureBuilder<String>(
                          future: getUserData(otherUid),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                            if (snapshot.hasData && snapshot.data != null){
                              
                              return  Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 5),
                              borderRadius: BorderRadius.circular(30),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(30),
                                child: CachedNetworkImage(
                                
                                height: 90,
                                width: 40,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF4cc485),),),
                                imageUrl: snapshot.data!,
                                errorBuilder: (context, url, error) => Image.asset('assets/images/blank_profile.png'),
                              ),
                              ),
                            );
      
                        
                            }
                            return Text("");
      
                          }),
                                              
                                              
                        
                        
                        
      
      
      
      
                        title: Text("${data.docs[index]['jobTitle']} • $displayName", 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),),
      
                        subtitle: Row(children: [Icon(Icons.message, color: Colors.white,), Expanded(
                          child: Text(" ${data.docs[index]['lastSender']}: ${data.docs[index]['lastMessage']} $profileImageURL ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                            ),),
                        ),],),
      
                          
                          
                        trailing: Text('',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                        ),
      
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ViewConversationPage(
                              chatId: data.docs[index].id,
                              otherDisplayName: displayName,
                              
                              
                              )));
                        },
                        
                        
                      ),
                    );
                  });
               }
               
               
               )
      
      
          ),
        ],
      ),
    );
  }

    

}

Future<String> getUserData(String id) async {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(id).get();
        if (doc.exists && doc.data() != null){
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          
             return data['profileImageURL'];
          
          
          
       

  }
  return '';
  }
 catch (e) {
  return '';
 }


  
  

}





  


