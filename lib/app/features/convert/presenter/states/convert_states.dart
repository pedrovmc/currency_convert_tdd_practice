import 'package:currency_convert_tdd_practice/app/core/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_entity.dart';

abstract class ConvertState {}

class ConvertInitialState implements ConvertState {
  const ConvertInitialState();
}

class ConvertLoadingState implements ConvertState {
  const ConvertLoadingState();
}

class ConvertErrorState implements ConvertState {
  final Failure error;
  ConvertErrorState(this.error);
}

class ConvertSuccessState implements ConvertState {
  final ConversionEntity conversionEntity;
  ConvertSuccessState(this.conversionEntity);
}
