import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../bloc/rest/rest_client.dart';
import '../../config/locator.dart';
import '../../models/post.dart';
import '../services/localstorage_service.dart';

String url_base = "http://localhost:8080";

class PostRepository {
  late RestAuthenticatedClient _client;
  late LocalStorageService _localStorageService;

  PostRepository() {
    _client = getIt<RestAuthenticatedClient>();
    _localStorageService = getIt<LocalStorageService>();
  }

  Future<PostList> fetchPosts([int _startIndex = 0]) async {
    String page = "/post/?page=${_startIndex}";

    String? token = _localStorageService.getFromDisk('user_token');

    final response = await http.get(
      Uri.parse(url_base + page),
      headers: {'Authorization': 'Bearer $token'},
    );

    print(response.body);
    return PostList.fromJson(jsonDecode(response.body));
  }

  Future<bool> postLike(int idPost) async {
    String? token = _localStorageService.getFromDisk('user_token');
    String urlLike = "/post/like/$idPost";

    final response = await http.post(Uri.parse(url_base + urlLike),
        headers: {'Authorization': 'Bearer $token'}, body: jsonEncode(idPost));
    print('The status code of your peticion are:');
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) return true;
    return false;
  }

  Future<PostList> fetchPostsLike([int _startIndex = 0]) async {
    String page = "/likes/?page=${_startIndex}";

    String? token = _localStorageService.getFromDisk('user_token');

    final response = await http.get(
      Uri.parse(url_base + page),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.body);
    return PostList.fromJson(jsonDecode(response.body));
  }
}
