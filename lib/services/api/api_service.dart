import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/dto/place_dto.dart';
import 'package:places/data/dto/places_filter_request_dto.dart';
import 'package:places/domain/model/place.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioApiService {
  final String _baseUrl = 'https://test-backend-flutter.surfstudio.ru';
  late final BaseOptions baseOptions;
  late final Dio dio;
  DioApiService() {
    baseOptions = BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        sendTimeout: 5000,
        responseType: ResponseType.json);
    dio = Dio(baseOptions)
      ..interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90),
      );
  }

  Future<List<PlaceDto>> getFilteredPlaces(
      PlacesFilterRequestDto requestBody) async {
    final response = await dio.post<List<dynamic>>('/filtered_places',
        data: jsonEncode(requestBody));
    if (response.statusCode == 200 && response.data != null) {
      var list = response.data!.map((e) => PlaceDto.fromJson(e)).toList();
      return list;
    }
    throw Exception(response.statusCode);
  }

  Future<Place> getPlace(int id) async {
    final response = await dio.get('/place/$id');
    if (response.statusCode == 200) {
      return Place.fromJson(response.data);
    }
    throw Exception(response.statusCode);
  }

  Future<Place> createPlace(Place place) async {
    final response = await dio.post('/place', data: jsonEncode(place));
    if (response.statusCode == 200) {
      return Place.fromJson(response.data);
    }
    throw Exception(response.statusCode);
  }

  Future<List<Place>> getAllPlaces() async {
    final response = await dio.get('/place');
    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception(response.statusCode);
  }
}
