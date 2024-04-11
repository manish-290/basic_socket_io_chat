import express from "express";
import { createServer } from "http";
import { Server as SocketServer } from "socket.io";

const app = express();
const PORT = process.env.PORT ||  3000;

app.get('/',(req,res)=>{
    res.send('Hello World!')
});


const server = createServer(app);
const socketio = new SocketServer(server);

socketio.on('connection',(socket)=>{
    console.log("Connnected successfully",socket.id);
    //for disconnected state
    socket.on("disconnect",()=>{
        console.log("User has been disconnected",socket.id);
    });
    //listen for event message
    socket.on("message",(data)=>{
        console.log(data);
        socket.broadcast.emit("message-received",data);
    })
   
});
server.listen(PORT,()=>{
    console.log("Server is running on:",PORT);
});


