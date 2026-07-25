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
String errorTitle = "";
String errorMessage = "";

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
                      onTap: () => showResetBox(context, emailResetController),
                      child: Text("Forgot Password?",
                      style: TextStyle(color: Colors.blue),
                      
                      
                      ),

                    ),


                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 5,),
                    child: ElevatedButton(
                      onPressed: () async {
                       try {
                        if (emailController.text == ""){
                          throw FirebaseAuthException(code: "invalid-email");
                        }
                         else if (passwordController.text == ""){
                          throw FirebaseAuthException(code: "invalid-credential");
                         }
                         
                      
                        await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                          email: emailController.text, 
                          password: passwordController.text);
                       }
                        on FirebaseAuthException catch (e) 
                       {
                         if (e.code == "invalid-email")
                         {
                            errorTitle = "Invalid Email Address!";
                            errorMessage = "Please ensure the email address includes '@' symbol and a domain (e.g. @gmail.com).";
                         }
                         else if (e.code == "invalid-credential"){
                            errorTitle = "Invalid Password";
                            errorMessage = "Please ensure the password is correct or reset password.";
                         }
                         else if (e.code == "network-request-failed"){
                            errorTitle = "Not Connected!";
                            errorMessage = "Please ensure that you are connected to the internet.";
                         }
                         else {
                            errorTitle = "Something Went Wrong!";
                            errorMessage = "Please try again later or contact support.";
                         }

                         showErrorBox(context);
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

void showErrorBox(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) 
    {
      return AlertDialog(
        backgroundColor: Color(0xFF4cc485),
        title: Text(errorTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight(600)
        ),
        ),
        content: Text(errorMessage,
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