library core;

export 'di/injection_container.dart';
export 'network/api_constants.dart';
export 'network/dio_client.dart';

import 'package:core/network/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  final String baseUrl;

  CoreModule({required this.baseUrl});

  @override
  List<Bind> get binds => [
        Bind((_) => Modular.get<DioClient>().dio, export: true),
        Bind((_) => DioClient(apiBaseUrl: baseUrl), export: true),
      ];

  @override
  List<ModularRoute> get routes => [];
}
