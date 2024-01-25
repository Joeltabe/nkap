import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class GroupChatPage extends StatefulWidget {
  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  List<ChatMessage> _messages = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  File? _selectedImage;

  void _sendMessage() async {
    String messageText = _textEditingController.text.trim();
    if (messageText.isNotEmpty || _selectedImage != null) {
      ChatMessage message = ChatMessage(
        senderName: 'Your Username',
        messageText: messageText,
        time: DateTime.now(),
        image: _selectedImage,
      );
      setState(() {
        _messages.add(message);
        _textEditingController.clear();
        _selectedImage = null;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMe)
            CircleAvatar(
              backgroundImage: AssetImage(message.senderPhoto),
              radius: 20,
            ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: message.isMe ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.senderName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: message.isMe ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  if (message.messageText.isNotEmpty)
                    Text(
                      message.messageText,
                      style: TextStyle(
                        color: message.isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  if (message.image != null)
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Image.file(message.image!),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 4.0),
                        child: kIsWeb
                            ? Image.network(
                                message.image!.path,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                message.image!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  SizedBox(height: 4.0),
                  Text(
                    '${message.time.hour}:${message.time.minute}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: message.isMe ? Colors.white70 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe)
            CircleAvatar(
              backgroundImage: AssetImage(message.senderPhoto),
              radius: 20,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
      ),
      body: Column(
        children: [
          Container(
            height: 80.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: groupMembers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(groupMembers[index].photo),
                    radius: 30,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildChatBubble(_messages[index]);
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type a message...',
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: _pickImage,
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String senderName;
  final String messageText;
  final DateTime time;
  final String senderPhoto;
  final bool isMe;
  final File? image;

  ChatMessage({
    required this.senderName,
    required this.messageText,
    required this.time,
    this.senderPhoto = 'assets/img/lover-removebg-preview 1.png',
    this.isMe = false,
    this.image,
  });
}

class GroupMember {
  final String photo;

  GroupMember({required this.photo});
}

List<GroupMember> groupMembers = [
  GroupMember(photo: 'assets/img/lover-removebg-preview 1.png'),
  GroupMember(photo: 'assets/img/lover-removebg-preview 1.png'),
  GroupMember(photo: 'assets/img/lover-removebg-preview 1.png'),
  GroupMember(photo: 'assets/img/lover-removebg-preview 1.png'),
  GroupMember(photo: 'assets/img/lover-removebg-preview 1.png'),
  GroupMember(photo: 'assets/img/lover-removebg-preview 1.png'),
];

void main() {
  runApp(MaterialApp(
    home: GroupChatPage(),
  ));
}
