import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_application/controller/chat_controller.dart';
import 'package:socket_application/model/message_model.dart';
import 'package:socket_application/widget/global.dart';
import 'package:socket_application/widget/message_item.dart';
import'package:socket_io_client/socket_io_client.dart' as IO;

class chatScreen extends StatefulWidget {
  const chatScreen({super.key});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {

 TextEditingController messageController = TextEditingController();
ChatController chatController = ChatController();
List<String> messages =[];

late IO.Socket socket;
//initialize the socket
@override 
void initState(){
 
    socket = IO.io("http://localhost:3000", IO.OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect()  // disable auto-connection
      .build()
  );
  socket.connect();
  setUpSocketListener();
   super.initState();

}
void setUpSocketListener(){
  socket.on('message-received', (data){
    print(data);
    chatController.chatMessage.add(Message.fromJson(data));
  });
}

@override
void dispose(){
  super.dispose();
  messageController.dispose();
}

void sendMessage(String message){
  var messageJson = {
    "message":message,
    "sentByMe":socket.id
  };
 socket.emit('message',messageJson);
     chatController.chatMessage.add(Message.fromJson(messageJson));

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 53, 93),
      title: Text("Messages",style:TextStyle(color:Colors.white)),
      centerTitle: true,
    ),
    body:Container(

      child:Column(children: [
        Expanded(flex:9,child: Obx(
          ()=>ListView.builder(
            itemCount: chatController.chatMessage.length,
            itemBuilder: (context,index){
              var currentItem = chatController.chatMessage[index];
              return MessageItem(
                message: currentItem.message,
                sentByme:currentItem.sentByMe == socket.id ,);
          })
        )),

        //for typing message textfield 
         Expanded(child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height:30,
          child:TextField(
            style: TextStyle(
              color:Colors.white,
              fontSize: 12
            ),
            cursorColor: Colors.blue,
            controller: messageController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.purple),
                borderRadius: BorderRadius.circular(12)),
                focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(color:Colors.purple),
                borderRadius: BorderRadius.circular(12)),
                hintText: "Type a message",
                hintStyle: TextStyle(color:Colors.grey[400],fontSize: 14),
                prefixIcon: Icon(Icons.mic,color: Colors.white,),
                suffixIcon: InkWell(
                  onTap: (){
                    sendMessage(messageController.text);
                    messageController.text = "";
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                       color:Colors.purple,
                    ),
                    child: Icon(Icons.send,color: Colors.white,),
                  ),
                )
            ),
          )
         )),

      ],)
    ));
  }
}