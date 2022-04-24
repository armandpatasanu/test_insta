import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testproject/screens/comments_screen.dart';
import 'package:testproject/utils/colors.dart';

class PostCard extends StatefulWidget {
  final snap;
  PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: ListView(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shrinkWrap: true,
                                children: [
                                  'Delete',
                                ]
                                    .map(
                                      (e) => InkWell(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ));
                  },
                  icon: Icon(Icons.more_vert),
                )
              ],
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: FadeInImage.memoryNetwork(
                  placeholder:
                      Uint8List.fromList(utf8.encode('assets/transparent.png')),
                  image: widget.snap['postUrl'],
                  imageErrorBuilder: (context, error, stacktrace) {
                    // Handle Error for the 1st time
                    return FadeInImage.memoryNetwork(
                      placeholder: Uint8List.fromList(
                          utf8.encode('assets/transparent.png')),
                      image: widget.snap['postUrl'],
                      imageErrorBuilder: (context, error, stacktrace) {
                        // Handle Error for the 2nd time
                        return FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          placeholder: Uint8List.fromList(
                              utf8.encode('assets/transparent.png')),
                          image: widget.snap['postUrl'],
                          imageErrorBuilder: (context, error, stacktrace) {
                            // Handle Error for the 3rd time to return text
                            return Center(child: Text('Image Not Available'));
                          },
                        );
                      },
                    );
                  })),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      snap: widget.snap,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_border,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${widget.snap['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: widget.snap['description'],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    child: const Text(
                      'View all comments',
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                  onTap: () {},
                ),
                Container(
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
