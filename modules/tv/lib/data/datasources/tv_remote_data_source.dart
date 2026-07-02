import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;

import '../models/tv_detail_model.dart';
import '../models/tv_model.dart';
import '../models/tv_response.dart';

abstract class TVRemoteDataSource {
  Future<List<TVModel>> getOnTheAirTV();

  Future<List<TVModel>> getPopularTV();

  Future<List<TVModel>> getTopRatedTV();

  Future<TVDetailResponse> getTVDetail(int id);

  Future<List<TVModel>> getTVRecommendations(int id);

  Future<List<TVModel>> searchTV(String query);
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  static const apiKey = 'api_key=6d37959d5d8ea4dd3aee259761d87076';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVModel>> getOnTheAirTV() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/on_the_air?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVDetailResponse> getTVDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TVDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTVRecommendations(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getPopularTV() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/popular?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTopRatedTV() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/top_rated?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> searchTV(String query) async {
    final response = await client.get(
      Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
