import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  


Future<(String, String)> getUserData(String uid) async {
try {
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

  if (doc.exists && doc.data() != null){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
     
     
    
      return ("${data['profileImageURL']}", data['bio'] as String);
     
    

  }
  return ("j", "j");
}
on FirebaseException catch (e) {
  return (e.code, "");
}
}



}