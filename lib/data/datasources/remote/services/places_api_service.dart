import '../api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../models/place_dto.dart';

class PlacesApiService {
  final ApiClient _client;
  const PlacesApiService(this._client);

  Future<PlacesResponse> getPlaces({int page = 0, int limit = 100}) async {
    final r = await _client.get<dynamic>(ApiConstants.places,
      queryParameters: {ApiConstants.paramPage: page, ApiConstants.paramLimit: limit});
    return PlacesResponse.fromJson(r.data as Map<String, dynamic>);
  }

  Future<List<PlaceDto>> getPlacesUpdatedSince(DateTime since) async {
    final r = await _client.get<dynamic>(ApiConstants.places,
      queryParameters: {ApiConstants.paramUpdatedSince: since.toIso8601String(), ApiConstants.paramLimit: 500});
    final raw = r.data;
    if (raw is List) return raw.map((e) => PlaceDto.fromJson(e as Map<String, dynamic>)).toList();
    return PlacesResponse.fromJson(raw as Map<String, dynamic>).data;
  }

  Future<List<CategoryDto>> getCategories() async {
    final r = await _client.get<dynamic>(ApiConstants.categories);
    final raw = r.data;
    final list = raw is List ? raw : (raw['data'] as List? ?? raw as List);
    return list.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>)).toList();
  }
}
