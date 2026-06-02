import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskerr/pages/explore_page.dart';
import 'package:taskerr/pages/login_page.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

 

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xFF4cc485),
      
      body: SingleChildScrollView(
        


          child: 
            

            
              
              Column(
                children: [

                 Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 220,),
                    child: Image.asset(
                      'assets/images/taskerr_logo_white.png',
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 10,),
                    
                    child: Text('Create an account and start finding freelance opportunities!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                     // fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),
                    ),
                  ),
                  



                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 50,),
                    child: TextField(

                      controller: emailController,

                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Email:',
                        
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
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 10,),
                    child: TextField(
                      controller: passwordController,

                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password:',
                        
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
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 15,),
                    child: ElevatedButton(
                      onPressed: () async {
                       try {
                        await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: emailController.text, 
                          password: passwordController.text);
                       }
                       catch (e) 
                       {
                        if (e.toString() == "[firebase_auth/invalid-email] The email address is badly formatted.")
                         print("Please check email");
                        
                        else (print(""));
                       };


                      } ,
                      child: const Text ("Sign Up"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      

                      
                    ),
                  ),
                
               
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20,),
                    child: RichText(text: TextSpan(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: "Already have an account? Login "),
                        TextSpan(
                          text: 'here',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                          }
                        ),
                    
                      ]
                    
                    )),
                  )


                  
                ],


              ),

             

          

            


              
            
       

         
          

          

          
         

          
          


         
          
         


          
        )
        

        
      
        
        
        


      



    );

      


    
  }
}