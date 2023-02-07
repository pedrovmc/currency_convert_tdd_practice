import 'package:currency_convert_tdd_practice/app/core/consts.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/domain/entity/currency_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/infra/datasources/currency_datasource.dart';
import 'package:currency_convert_tdd_practice/app/features/select_currencies/infra/models/currency_model.dart';

class CurrencyDatasourceImpl extends CurrencyDatasource {
  final RestClient restClient;

  CurrencyDatasourceImpl({required this.restClient});

  @override
  Future<List<CurrencyEntity>> getCurrencies() async {
    final result = await restClient.get("$baseUrl/codes");

    final currencyModelList = (result.data["supported_codes"] as List)
        .map((e) => CurrencyModel.fromMap(e))
        .toList();

    return currencyModelList;
  }
}
