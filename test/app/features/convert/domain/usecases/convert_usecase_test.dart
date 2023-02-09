import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/exceptions.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/repositories/currency_repository.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/usecases/convert_usecase.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/conversion_model.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/conversion_params_model.dart';
import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CurrencyRepositoryMock extends Mock implements CurrencyRepository {}

class ConversionParamsModelMock extends Mock implements ConversionParamsEntity {
}

void main() {
  late ConvertUsecase sut;
  late ConversionParamsModel params;
  late CurrencyRepository currencyRepository;
  late ConversionParamsEntity paramsMock;
  setUp(() {
    currencyRepository = CurrencyRepositoryMock();
    sut = ConvertUsecaseImpl(currencyRepository: currencyRepository);
    params = ConversionParamsModel(
      amount: faker.randomGenerator.decimal(scale: 3),
      from: faker.randomGenerator.string(3, min: 3),
      to: faker.randomGenerator.string(3, min: 3),
    );
    paramsMock = ConversionParamsModelMock();
  });

  group("ConvertUsecase", () {
    test(
        "When the usecase is correctly called, should call repository with right parameters",
        () async {
      when(() => currencyRepository.convert(conversionParamsEntity: params))
          .thenAnswer(
        (_) async => Right(
          ConversionModel(rate: 1.0, result: 1.0),
        ),
      );
      await sut(conversionParamsEntity: params);

      verify(
        () => currencyRepository.convert(conversionParamsEntity: params),
      ).called(1);
    });

    test(
        "When the repository returns a left with ConnectionFailure, should return a left with a ConnectionFailure",
        () async {
      when(() => currencyRepository.convert(conversionParamsEntity: params))
          .thenAnswer(
        (_) async => Left(
          ConnectionFailure(""),
        ),
      );
      final result = await sut(conversionParamsEntity: params);
      final foldedResult = result.fold((l) => l, (r) => r);

      expect(foldedResult, isA<ConnectionFailure>());
    });

    test(
        "When the entity has invalid currency code, should return a left with a InvalidCurrencyCodeFailure",
        () async {
      when(() => paramsMock.validate())
          .thenThrow(InvalidCurrencyCodeException());

      final result = await sut(conversionParamsEntity: paramsMock);
      final foldedResult = result.fold((l) => l, (r) => r);

      expect(foldedResult, isA<InvalidCurrencyCodeFailure>());
    });

    test(
        "When the entity has 0 digits on amount, should return a ZeroConversionAmountFailure",
        () async {
      when(() => paramsMock.validate())
          .thenThrow(ZeroConversionAmountException());
      final result = await sut(conversionParamsEntity: paramsMock);
      final foldedResult = result.fold((l) => l, (r) => r);

      expect(foldedResult, isA<ZeroConversionAmountFailure>());
    });

    test(
        "When the repository returns a right with a ConversionEntity, should return a right with a ConversionEntity",
        () async {
      final mockedResult = ConversionModel(rate: 1.0, result: 1.0);
      when(() => currencyRepository.convert(conversionParamsEntity: params))
          .thenAnswer(
        (_) async => Right(
          mockedResult,
        ),
      );
      final result = await sut(conversionParamsEntity: params);
      final foldedResult = result.fold((l) => l, (r) => r);

      expect(foldedResult, mockedResult);
    });
  });
}
