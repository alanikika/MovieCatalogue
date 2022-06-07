import 'package:core/network/dio_client.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> init(String baseUrl) async {
  //Network
  di.registerLazySingleton(() => DioClient(apiBaseUrl: baseUrl));
}
