import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:manpro/features/bagian_utama/models/post_Model.dart';
import 'dart:convert';
import 'package:manpro/utils/constants/api_constants.dart';
import 'package:manpro/features/bagian_utama/models/comment_Model.dart';

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<CommentModel>> comments = Rx<List<CommentModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}feeds'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        for (var item in json.decode(response.body)['feeds']) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({
    required String content,
  }) async {
    try {
      var data = {
        'content': content,
      };

      var response = await http.post(
        Uri.parse('${url}feed/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        print(json.decode(response.body));
      } else {
        Get.snackbar('Error', 
        json.decode(response.body)['message'],
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getComments(id) async {
   try {
    comments.value.clear();
    isLoading.value = true;

    var response = await http.get(
      Uri.parse('${url}feed/comments/$id'), 
      headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${box.read('token')}',
    }
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
     final content = json.decode(response.body)['comments'];
     for (var item in content) {
      comments.value.add(CommentModel.fromJson(item));
     }
    } else {
      isLoading.value = false;
      print(json.decode(response.body));
    }

   } catch (e) {
    print(e.toString());
   }
  }

  Future createComment(id, body) async{
    try {
      isLoading.value = true;
      var data = {
        'body': body,
      };

      var request = await http.post(
        Uri.parse('${url}feed/comment/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (request.statusCode == 201) {
        isLoading.value = false;  
        print(json.decode(request.body));
      } else {
        isLoading.value = false;
        print(json.decode(request.body));
      }

    } catch (e) {
      print(e.toString());
    }
  }

  Future likeAndUnlike(id) async{
   try {
    isLoading.value = true;

    var request = await http.post(
      Uri.parse('${url}feed/like/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    if (request.statusCode == 200 || json.decode(request.body)['message'] == 'Liked') {
      isLoading.value = false;
      print(json.decode(request.body));
    }else if (request.statusCode == 200 || json.decode(request.body)['message'] == 'Unliked') {
      isLoading.value = false;
      print(json.decode(request.body));
    }
    
   } catch (e) {
    print(e.toString());
   }
  }
}
