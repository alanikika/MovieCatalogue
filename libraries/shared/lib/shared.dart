library shared;

export 'common/custom_colors.dart';
export 'common/constants.dart';
export 'common/dimens.dart';
export 'common/image_path.dart';
export 'common/routes.dart';
export 'common/strings.dart';
export 'common/styles.dart';
export 'widget/card_movie.dart';
export 'widget/custom_app_bar.dart';
export 'widget/error_image.dart';
export 'widget/loading_circular.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/shared.dart';

class SharedModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((_) => CustomColors()),
    Bind((_) => Dimens()),
    Bind((_) => ImagePath()),
    Bind((_) => Routes()),
    Bind((_) => Strings()),
  ];

  @override
  List<ModularRoute> get routes => throw UnimplementedError();

}