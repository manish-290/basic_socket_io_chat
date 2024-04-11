// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:socket_application/widget/global.dart';

class MessageItem extends StatelessWidget {
  final bool sentByme;
  final String message;
  MessageItem({
    Key? key,
    required this.sentByme,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByme? Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        margin: EdgeInsets.only(top:20,right: 10),
        //  color:widget.sentByme? Colors.blue:Colors.grey[500],
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:sentByme? Colors.blue:Colors.grey[500],

         ),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message,style:TextStyle(
              fontSize:16 ,
              color:Colors.white
            )),SizedBox(width: 5,),
            Text("11:11 AM",style:TextStyle(
              fontSize:8 ,
              color:Colors.grey[200]
            ))
          ],
        )
      ),
    );
  }
}
