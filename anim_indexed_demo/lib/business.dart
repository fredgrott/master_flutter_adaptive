

import 'package:flutter/material.dart';



class Business extends StatelessWidget{
  const Business({super.key});


  @override
  Widget build(BuildContext context) {
    return  Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    child:
                        const Text("Business"))
  ]);
  }

}
