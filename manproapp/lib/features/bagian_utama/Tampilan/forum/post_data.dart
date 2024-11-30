import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manpro/features/bagian_utama/models/post_Model.dart';
import 'package:manpro/features/bagian_utama/Tampilan/forum/post_details.dart';

class PostData extends StatelessWidget {
  const PostData({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.user!.username!, style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),),
            Text(post.user!.email!, style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
            ),),
            const SizedBox(height: 10,),
            Text(post.content!, style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                IconButton(onPressed: () {
                  Get.to(() => PostDetails(
                    post: post,));
                }, icon: Icon(Icons.comment)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
