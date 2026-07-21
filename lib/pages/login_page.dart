import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskerr/pages/explore_page.dart';
import 'package:taskerr/pages/signup_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

 

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isPasswordObscured = true;

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailResetController = TextEditingController();
  

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
                    
                    child: Text('Welcome back your next freelance opportunity is waiting!',
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
                        hintText: 'Enter Email:',
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
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 10,),
                    child: TextField(
                      controller: passwordController,
                 
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                        
                        
                      ),
                      obscureText: isPasswordObscured,
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Password:',
                        prefixIcon: Icon(Icons.lock, color: Colors.grey,),
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordObscured ? Icons.visibility_off: Icons.visibility, color: Colors.grey,),
                          onPressed: () => setState(() => isPasswordObscured = !isPasswordObscured),
                          
                        
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
                  
                    GestureDetector(
                      onTap: () => showErrorBox(context, emailResetController),
                      child: Text("Forgot Password?",
                      style: TextStyle(color: Colors.blue),
                      
                      
                      ),

                    ),


                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 5,),
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
                        const TextSpan(text: "Don't have an account? Sign up "),
                        TextSpan(
                          text: 'here',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                          }
                        ),
                    
                      ]
                    
                    )),
                  ),

                  
                  
                ],


              ),

             

          

            


              
            
       

         
          

          

          
         

          
          


         
          
         


          
        )
        

        
      
        
        
        


      



    );

      


    
  }

  
}

void showErrorBox(BuildContext context, final emailResetController,)
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
                        hintText: 'Enter Reset Email:',
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