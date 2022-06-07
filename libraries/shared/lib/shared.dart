library shared;

export 'common/custom_colors.dart';
export 'common/dimens.dart';
export 'common/image_path.dart';
export 'common/routes.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/common/custom_colors.dart';
import 'package:shared/common/dimens.dart';
import 'package:shared/common/image_path.dart';
import 'package:shared/common/shared.dart';

class SharedModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((_) => CustomColors()),
    Bind((_) => Dimens()),
    Bind((_) => ImagePath()),
    Bind((_) => Routes()),
  ];

  @override
  List<ModularRoute> get routes => throw UnimplementedError();

}