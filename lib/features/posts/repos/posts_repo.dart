import 'dart:convert';
import 'dart:developer' as l;

import 'package:bloc_apicall_practice/features/posts/models/post_data_model.dart';
import 'package:http/http.dart' as http;


class PostsRepo{

  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];

    try{

      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      List result = jsonDecode(response.body);

      for(int i= 0; i<result.length; i++){
        PostDataUiModel post = PostDataUiModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }

      return posts;

    } catch(e){
      l.log(e.toString());
      return [];
    }
  }


  static Future<bool> addPost(String title, String body, String userId) async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": title,
        "body": body,
        "userId": userId
      });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.statusCode);
        print("Post added successfully with status code: ${response.statusCode}");
        return true;
      } else {
        print("Failed to add post with status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      l.log(e.toString());
      return false;
    }
  }

}