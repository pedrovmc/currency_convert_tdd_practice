import 'package:currency_convert_tdd_practice/app/features/convert/domain/entity/currency_entity.dart';

abstract class CurrencyDatasource {
  Future<List<CurrencyEntity>> getCurrencies();
}
