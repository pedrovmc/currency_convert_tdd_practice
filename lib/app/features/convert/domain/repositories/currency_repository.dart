import 'package:currency_convert_tdd_practice/app/core/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/currency_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, List<CurrencyEntity>>> getCurrencies();
  Future<Either<Failure, ConversionEntity>> convert({
    required ConversionParamsEntity conversionParamsEntity,
  });
}
