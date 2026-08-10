import 'package:flutter/material.dart';

class AdminViewTaskPage extends StatefulWidget {
  const AdminViewTaskPage({super.key});

  @override
  State<AdminViewTaskPage> createState() => _AdminViewTaskPageState();
}

class _AdminViewTaskPageState extends State<AdminViewTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200,),
            ElevatedButton(onPressed: ()
            { Navigator.pop(context, true); }, 
            child: Text("Approve"))
          ],
        ),
      ),
    );
  }
}