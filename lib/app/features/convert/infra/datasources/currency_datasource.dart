import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/currency_entity.dart';

abstract class CurrencyDatasource {
  Future<List<CurrencyEntity>> getCurrencies();
  Future<ConversionEntity> convert(ConversionParamsEntity params);
}
