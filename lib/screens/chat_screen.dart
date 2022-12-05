import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sugar_cubes/shared/app_styles.dart';
import 'package:sugar_cubes/widgets/sugar_message.dart';

class ChatScreen extends StatefulWidget {
  final String sugarname;
  final String sugarJarId;
  final String sugarJar;

  const ChatScreen({required this.sugarname, required this.sugarJarId, required this.sugarJar, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream<QuerySnapshot>? chat; 
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.cloud,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Styles.aqua,
        title: Text(
          widget.sugarJar,
          style: GoogleFonts.josefinSans(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500
          ),
        )
      ),

      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,

            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 48,
              color: Styles.sakura,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      textAlignVertical: TextAlignVertical.bottom,
                      style: GoogleFonts.josefinSans(
                        color: Styles.sugar,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                        cursorColor: Styles.aqua,
                      cursorRadius: const Radius.circular(20),
                      cursorWidth: 2,
                      cursorHeight: 16,
                        decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 16, right: 20),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                          hintText: 'Send a message',
                        hintStyle: GoogleFonts.josefinSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Styles.sugar,
                        ),
                      )
                    )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chat,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return SugarMessage(
              message: snapshot.data.docs[index]['message'], 
              sender: snapshot.data.docs[index]['sender'], 
              sendByMe: widget.sugarname == snapshot.data.docs[index]['sender']
            );
          },
        ) : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessagesMap = {
        'message' = messageController.text,
        'sender' = widget.sugarname,
        'time' = DateTime.now().millisecondsSinceEpoch
      };
    }
  }
}