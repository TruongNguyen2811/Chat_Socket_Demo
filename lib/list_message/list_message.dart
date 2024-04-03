import 'dart:convert';

import 'package:chat_socket/list_message/widget/message_multimedia.dart';
import 'package:chat_socket/list_message/widget/message_text.dart';
import 'package:chat_socket/model/form_item.dart';
import 'package:chat_socket/model/message_response.dart';
import 'package:chat_socket/ultils/utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildMessage extends StatefulWidget {
  SendMessageResponse message;
  bool isMe;
  BuildMessage({super.key, required this.message, required this.isMe});

  @override
  State<BuildMessage> createState() => _BuildMessageState();
}

class _BuildMessageState extends State<BuildMessage> {
  bool hidden = false;
  @override
  Widget build(BuildContext context) {
    List<String> images = [];
    List<String> video = [];
    if (widget.message.type == 5) {
      var x = FormData.fromJson(json.decode(widget.message.originalMessage!));
      for (var e in x.valueImage!) {
        images.add(e.image!);
      }
    }
    if (widget.message.type == 7) {
      var x = FormData.fromJson(json.decode(widget.message.originalMessage!));

      images.add(x.urlVideo!);
    }
    return Column(
      children: [
        if (hidden) const SizedBox(height: 4),
        if (hidden)
          Text(
            'qe3123',
            // Utils.formatMessageDate(widget.data.createdAtStr!),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(175, 177, 175, 1),
              fontSize: 12,
            ),
          ),
        if (hidden) const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            mainAxisAlignment:
                widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (widget.message.type == null) ...[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      hidden ? hidden = false : hidden = true;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: widget.isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      MessageText(
                        message: widget.message,
                        isMe: widget.isMe,
                      ),
                      if (hidden) ...[
                        const SizedBox(height: 4),
                        Text(
                          'qe3123',
                          // Utils.formatMessageDate(widget.data.createdAtStr!),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color.fromRGBO(175, 177, 175, 1),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ]
                    ],
                  ),
                ),
              ],
              if (widget.message.type == 5) ...[
                Container(
                  constraints: BoxConstraints(
                      minWidth: 0, maxWidth: images.length == 1 ? 160 : 246),
                  child: MediaGridview(
                    mediaURLs: images,
                    type: MediaGridviewType.grid,
                    width: images.length == 1 ? 160 : 246,
                  ),
                )
              ],
              if (widget.message.type == 7) ...[
                Container(
                  constraints: BoxConstraints(
                      minWidth: 0, maxWidth: images.length == 1 ? 160 : 246),
                  child: MediaGridview(
                    mediaURLs: images,
                    type: MediaGridviewType.grid,
                    width: images.length == 1 ? 160 : 246,
                  ),
                )
              ],
            ],
          ),
        ),
      ],
    );
  }
}
