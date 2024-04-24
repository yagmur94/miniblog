import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;

class ArticleRepository {
  Future<List<Blog>> fetchAll() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);
    return jsonData.map((json) => Blog.fromJson(json)).toList();
  }

  Future<Blog> fetchArticleId(String id) async {
    Uri url =
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$id");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);
    return Blog.fromJson(jsonData);
  }

    Future<void> fetchDeleteBlogsId(String blogID) async {
    Uri url =
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$blogID");
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        const Text("Blog başarıyla silindi!");
      } else {
        const Text("Blog silinemedi");
      }
    } catch (e) {
      const Text("Hata oluştu!");
    }
  }

  Future<void> postArticle(
      String title, String content, String author, String selectedImage) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    var request = http.MultipartRequest("POST", url);

    request.files.add(await http.MultipartFile.fromPath("File", selectedImage));

    request.fields['Title'] = title;
    request.fields['Content'] = content;
    request.fields['Author'] = author;

    await request.send();
  }
}