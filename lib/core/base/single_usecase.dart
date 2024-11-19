import 'dart:async';

import './usecase_value.dart';

abstract class SingleUsecase<M>  {
  FutureOr<UsecaseValue<M>> call();
}
