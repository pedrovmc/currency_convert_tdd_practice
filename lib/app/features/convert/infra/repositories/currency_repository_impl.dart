import 'package:currency_convert_tdd_practice/app/core/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/core/rest_client/rest_client_exception.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/currency_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/repositories/currency_repository.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/datasources/currency_datasource.dart';
import 'package:dartz/dartz.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final CurrencyDatasource currencyDatasource;

  CurrencyRepositoryImpl({required this.currencyDatasource});

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies() async {
    try {
      final result = await currencyDatasource.getCurrencies();

      if (result.isEmpty) {
        return Left(EmptyCurrenciesFailure("Empty currencies"));
      }
      return Right(result);
    } on RestClientException {
      return Left(ConnectionFailure("Server error"));
    }
  }

  @override
  Future<Either<Failure, ConversionEntity>> convert(
      {required ConversionParamsEntity conversionParamsEntity}) async {
    try {
      final result = await currencyDatasource.convert(conversionParamsEntity);
      return Right(result);
    } on RestClientException {
      return Left(ConnectionFailure("Server error"));
    }
  }
}
