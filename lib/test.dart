import 'package:flutter/material.dart';

class Test extends StatelessWidget{
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: Container(
         // alignment: Alignment.center,
         color: Colors.red,
         height: 200,
         width: 200,
         child: Container(
           height: 50,
           width: 50,
           color: Colors.green,
         ),

       ),
     ),
   );
  }
}