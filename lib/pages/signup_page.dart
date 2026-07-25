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

  final displayNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  String errorTitle = "";
  String errorMessage = "";

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
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 40,),
                    child: TextField(

                      controller: displayNameController,

                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Username:',
                        prefixIcon: Icon(Icons.person, color: Colors.grey,),
                        
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
                      obscureText: isPasswordObscured,
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password:',
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

                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 10,),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: isConfirmPasswordObscured,
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Confirm Password:',
                        prefixIcon: Icon(Icons.lock_reset, color: Colors.grey,),
                        suffixIcon: IconButton(
                          icon: Icon(isConfirmPasswordObscured ? Icons.visibility_off: Icons.visibility, color: Colors.grey,),
                          onPressed: () => setState(() => isConfirmPasswordObscured = !isConfirmPasswordObscured),
                          
                        
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
                  


                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80, top: 15,),
                    child: ElevatedButton(
                      onPressed: () async {
                       try {
                          if (displayNameController.text == ""){
                            throw FirebaseAuthException(code: 'invalid-display-name');
                          }
                          else if (emailController.text == ""){
                            throw FirebaseAuthException(code: "invalid-email");
                          }
                        
                          else if (passwordController.text == ""){
                            throw FirebaseAuthException(code: "weak-password");
                          }
                          else if (passwordController.text != confirmPasswordController.text){
                            throw FirebaseAuthException(code: 'confirm-password-does-not-match-password');
                          }
                        await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: emailController.text, 
                          password: passwordController.text);
                        



                          setState(() {
                            
                          });
                          
                            await FirebaseAuth.instance.currentUser!.updateDisplayName(displayNameController.text,);

                          
                        
                       }


                       on FirebaseAuthException catch(e)
                       {
                        if (e.code == "weak-password") { 
                         errorTitle = "Password Too Weak!";
                         errorMessage = "Please ensure the password is atleast 6 characters long.";
                        }
                        else if (e.code == "email-already-in-use") {
                          errorMessage = "An account already exists with that email.";
                        }
                        else if (e.code == "invalid-email") {
                          errorTitle = "Invalid Email Address!";
                          errorMessage = "Please ensure the email address includes '@' symbol and a domain (e.g. @gmail.com).";
                        }
                        else if (e.code == "network-request-failed"){
                          errorTitle = "Not Connected!";
                          errorMessage = "Please ensure that you are connected to the internet.";

                        }
                        else if (e.code == "invalid-display-name"){
                          errorTitle = "Name Required!";
                          errorMessage = "Please ensure a name is entered.";
                        }
                        else if (e.code == "confirm-password-does-not-match-password"){
                          errorTitle = "Password Does Not Match!";
                          errorMessage = "Please ensure password and confirm password match.";
                        }
                        else { 
                          errorTitle = "Something Went Wrong!";
                          errorMessage = "Please try again later or contact support.";
                          }
                        showErrorBox(context);

                        
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
}
