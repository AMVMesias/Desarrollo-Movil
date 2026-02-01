import 'package:flutter/material.dart';
import '../../domain.models/mensaje.dart';
import '../temas/chat_colors.dart';

class ChatBubble extends StatelessWidget {
  final Mensaje mensaje;
  final bool isMyMessage;

  const ChatBubble({
    Key? key,
    required this.mensaje,
    required this.isMyMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment:
            isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMyMessage) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: ChatColors.lightGreen,
              child: Text(
                mensaje.autor.isNotEmpty ? mensaje.autor[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: ChatColors.whiteText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isMyMessage
                    ? ChatColors.myMessageColor
                    : ChatColors.otherMessageColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isMyMessage ? 20 : 5),
                  bottomRight: Radius.circular(isMyMessage ? 5 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ChatColors.shadowColor,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMyMessage) ...[
                    Text(
                      mensaje.autor,
                      style: const TextStyle(
                        color: ChatColors.darkGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    mensaje.texto,
                    style: const TextStyle(
                      color: ChatColors.primaryText,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _formatTime(mensaje.timestamp),
                        style: const TextStyle(
                          color: ChatColors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                      if (isMyMessage) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.done_all,
                          size: 14,
                          color: ChatColors.primaryGreen,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMyMessage) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: ChatColors.primaryGreen,
              child: Text(
                mensaje.autor.isNotEmpty ? mensaje.autor[0].toUpperCase() : 'M',
                style: const TextStyle(
                  color: ChatColors.whiteText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(int timestamp) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
