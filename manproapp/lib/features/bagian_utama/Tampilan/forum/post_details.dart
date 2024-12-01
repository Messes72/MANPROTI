import 'package:flutter/material.dart';
import 'package:manpro/features/bagian_utama/Tampilan/forum/post_data.dart';
import 'package:manpro/features/bagian_utama/Tampilan/forum/post_field.dart';
import 'package:manpro/features/bagian_utama/models/post_Model.dart';
import 'package:manpro/features/bagian_utama/controllers/postController.dart';
import 'package:get/get.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post});

  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

  class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(widget.post.user!.username!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PostData(
                post: widget.post,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: 575,
                  child: Obx(() {
                      return _postController.isLoading.value ? 
                      Center(
                        child: CircularProgressIndicator()) 
                        
                        : ListView.builder(
                          itemCount: _postController.comments.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_postController.comments.value[index].user!.username!),
                              subtitle: Text(_postController.comments.value[index].body!),
                            );
                          });
                    }
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostField(
                    obscureText: false,
                    hintText: 'Tulis komentar Anda...',
                    controller: _commentController,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await _postController.createComment(
                        widget.post.id, 
                        _commentController.text.trim()
                        );
                      _commentController.clear();
                      _postController.getComments(widget.post.id);
                    },
                    child: const Text('Comment',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
