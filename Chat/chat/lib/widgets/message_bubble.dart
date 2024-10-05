import 'package:flutter/material.dart';

// A MessageBubble for showing a single chat message on the ChatScreen.
/*class MessageBubble extends StatelessWidget {
  // Create a message bubble which is meant to be the first in the sequence.
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  // Create a amessage bubble that continues the sequence.
  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  // Whether or not this message bubble is the first in a sequence of messages
  // from the same user.
  // Modifies the message bubble slightly for these different cases - only
  // shows user image for the first message from the same user, and changes
  // the shape of the bubble for messages thereafter.
  final bool isFirstInSequence;

  // Image of the user to be displayed next to the bubble.
  // Not required if the message is not the first in a sequence.
  final String? userImage;

  // Username of the user.
  // Not required if the message is not the first in a sequence.
  final String? username;
  final String message;

  // Controls how the MessageBubble will be aligned.
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            // Align user image to the right, if the message is from me.
            right: isMe ? 0 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userImage!,
              ),
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          ),
        Container(
          // Add some margin to the edges of the messages, to allow space for the
          // user's image.
          margin: const EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            // The side of the chat screen the message should show at.
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // First messages in the sequence provide a visual buffer at
                  // the top.
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                        right: 13,
                      ),
                      child: Text(
                        username!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                  // The "speech" box surrounding the message.
                  Container(
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.grey[300]
                          : theme.colorScheme.secondary.withAlpha(200),
                      // Only show the message bubble's "speaking edge" if first in
                      // the chain.
                      // Whether the "speaking edge" is on the left or right depends
                      // on whether or not the message bubble is the current user.
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    // Set some reasonable constraints on the width of the
                    // message bubble so it can adjust to the amount of text
                    // it should show.
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    // Margin around the bubble.
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        // Add a little line spacing to make the text look nicer
                        // when multilined.
                        height: 1.3,
                        color: isMe
                            ? Colors.black87
                            : theme.colorScheme.onSecondary,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
*/
class MessageBubble extends StatelessWidget {
  final String? userName;
  final String? imageUrl;
  final bool isMe;
  final String message;
  final bool first;

  const MessageBubble.first(
      {super.key,
      required this.userName,
      required this.imageUrl,
      required this.isMe,
      required this.message})
      : first = true;

  const MessageBubble.next(
      {super.key, required this.isMe, required this.message})
      : first = false,
        imageUrl = null,
        userName = null;

  @override
  Widget build(BuildContext context) {
    if ((isMe && first) || (!isMe && first)) {
      return Stack(
        children: [
          Positioned(
            top: 20,
            right: isMe ? 0 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl!),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(44, 20, 44, 2),
            child: Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName!,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: isMe
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Colors.grey,
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                          // Add a little line spacing to make the text look nicer
                          // when multilined.
                          height: 1.3,
                          color: isMe
                              ? Colors.black87
                              : Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else if ((isMe && !first) || (!isMe && !first)) {
      return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 46, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: isMe
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Colors.grey,
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    // Add a little line spacing to make the text look nicer
                    // when multilined.
                    height: 1.3,
                    color: isMe
                        ? Colors.black87
                        : Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
          //  const SizedBox(width: 10),
          // Container(),
        ],
      );
    }
    return Container();
  }
}
