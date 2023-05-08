import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:places/data/dto/place_dto.dart';
import 'package:places/data/dto/places_filter_request_dto.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/services/api/network_exception.dart';
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
    try {
      final response = await dio.post<List<dynamic>>(
        '/filtered_places',
        data: jsonEncode(requestBody),
      );
      if (response.statusCode == 200 && response.data != null) {
        var list = response.data!.map((e) => PlaceDto.fromJson(e)).toList();
        return list;
      }
      throw NetworkException(
          endpoint: response.requestOptions.path,
          code: response.statusCode.toString(),
          error: response.statusMessage);
    } on DioError catch (e) {
      log('DioError in getFilteredPlaces', error: e.message);
      throw NetworkException(
          endpoint: e.requestOptions.path,
          code: e.response?.statusCode.toString(),
          error: e.message);
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  Future<Place> getPlace(int id) async {
    try {
      final response = await dio.get('/place/$id');
      if (response.statusCode == 200) {
        return Place.fromJson(response.data);
      }
      throw NetworkException(
          endpoint: response.requestOptions.path,
          code: response.statusCode.toString(),
          error: response.statusMessage);
    } on DioError catch (e) {
      log('DioError in getFilteredPlaces', error: e.message);
      throw NetworkException(
          endpoint: e.requestOptions.path,
          code: e.response?.statusCode.toString(),
          error: e.message);
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  Future<Place> createPlace(Place place) async {
    try {
      final response = await dio.post('/place', data: jsonEncode(place));

      if (response.statusCode == 200) {
        return Place.fromJson(response.data);
      }
      throw NetworkException(
          endpoint: response.requestOptions.path,
          code: response.statusCode.toString(),
          error: response.statusMessage);
    } on DioError catch (e) {
      log('DioError in getFilteredPlaces', error: e.message);
      throw NetworkException(
          endpoint: e.requestOptions.path,
          code: e.response?.statusCode.toString(),
          error: e.message);
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  Future<List<Place>> getAllPlaces() async {
    try {
      final response = await dio.get('/place');

      if (response.statusCode == 200) {
        return response.data;
      }
      throw NetworkException(
          endpoint: response.requestOptions.path,
          code: response.statusCode.toString(),
          error: response.statusMessage);
    } on DioError catch (e) {
      log('DioError in getFilteredPlaces', error: e.message);
      throw NetworkException(
          endpoint: e.requestOptions.path,
          code: e.response?.statusCode.toString(),
          error: e.message);
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}
