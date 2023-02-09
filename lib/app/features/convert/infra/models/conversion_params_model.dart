import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';

class ConversionParamsModel extends ConversionParamsEntity {
  ConversionParamsModel({
    required super.from,
    required super.to,
    required super.amount,
  });
}
