import 'package:currency_convert_tdd_practice/app/core/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/exceptions.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';

abstract class ConvertUsecase {
  Future<Either<Failure, ConversionEntity>> call({
    required ConversionParamsEntity conversionParamsEntity,
  });
}

class ConvertUsecaseImpl extends ConvertUsecase {
  final CurrencyRepository currencyRepository;

  ConvertUsecaseImpl({required this.currencyRepository});

  @override
  Future<Either<Failure, ConversionEntity>> call({
    required ConversionParamsEntity conversionParamsEntity,
  }) async {
    try {
      conversionParamsEntity.validate();
      final result = await currencyRepository.convert(
          conversionParamsEntity: conversionParamsEntity);
      return result;
    } on InvalidCurrencyCodeException {
      return Left(InvalidCurrencyCodeFailure(message: "Invalid currency code"));
    } on ZeroConversionAmountException {
      return Left(
          ZeroConversionAmountFailure(message: "Zero conversion amount"));
    } catch (e) {
      rethrow;
    }
  }
}
