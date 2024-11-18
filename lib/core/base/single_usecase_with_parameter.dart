import 'dart:async';

import './usecase_value.dart';

abstract class SingleUsecaseWithParameter<M, P>  {
  FutureOr<UsecaseValue<M>> call(P data);
}
