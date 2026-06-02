import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskerr/pages/explore_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

 

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFFb8d8be),
      
      body: Center(



          child: 
            

            Container(

               height: 500,
               width: 400,

              decoration: BoxDecoration(
                color: Color(0xFF4cc485),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF4cc485).withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 10,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              
              
              child: Column(
                children: [

                 Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 50,),
                    child: Image.asset(
                      'assets/images/taskerr_logo_white.png',
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 20,),
                    
                    child: Text('Welcome back your next freelance opportunity is waiting!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),
                    ),
                  ),
                  



                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 50,),
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
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 10,),
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
                        .signInWithEmailAndPassword(
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
                      child: const Text ("Login"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      

                      
                    ),
                  ),
                
               
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 15,),
                    child: RichText(text: TextSpan(
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: "Don't have an account? Sign up "),
                        TextSpan(
                          text: 'here',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ExplorePage()));
                          }
                        ),
                    
                      ]
                    
                    )),
                  )


                  
                ],


              ),

             ),

          

            


              
            
       

         
          

          

          
         

          
          


         
          
         


          
        )
        

        
      
        
        
        


      



    );

      


    
  }
}