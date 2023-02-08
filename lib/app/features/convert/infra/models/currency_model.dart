import 'package:currency_convert_tdd_practice/app/features/convert/domain/entity/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  CurrencyModel({required super.code, required super.name});

  factory CurrencyModel.fromMap(List list) {
    return CurrencyModel(code: list.first, name: list.last);
  }
}
