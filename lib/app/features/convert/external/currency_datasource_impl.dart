import 'package:currency_convert_tdd_practice/app/core/consts.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/currency_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/datasources/currency_datasource.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/conversion_model.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/currency_model.dart';

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

  @override
  Future<ConversionEntity> convert(ConversionParamsEntity params) async {
    final result = await restClient
        .get("$baseUrl/pair/${params.from}/${params.to}/${params.amount}");

    return ConversionModel.fromMap(result.data);
  }
}
