import 'package:dio/dio.dart';
import 'package:flutter_app/repository/remote_data_source/remote_source_interface.dart';

class AppRemoteSource implements RemoteSourceInterface {
  final Dio _dio;

  AppRemoteSource._(this._dio);

  factory AppRemoteSource(String hostUrl) {
    BaseOptions options = BaseOptions(
      baseUrl: hostUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio _dio = Dio(options);

    return AppRemoteSource._(_dio);
  }

  @override
  Future<String> getHttp() async {
    try {
      Response response = await _dio.get(_dio.options.baseUrl);
      return response.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
