import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/errors/errors.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/usecases/convert_usecase.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/conversion_model.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/conversion_params_model.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/convert_controller.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/states/convert_states.dart';
import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:value_listenable_test/value_listenable_test.dart';

class ConvertUsecaseMock extends Mock implements ConvertUsecase {}

void main() {
  late ConvertController sut;
  late ConvertUsecase convertUsecase;
  late ConversionParamsEntity params;
  setUp(() {
    convertUsecase = ConvertUsecaseMock();
    sut = ConvertController(
      convertUsecase: convertUsecase,
    );

    final from = faker.randomGenerator.string(3, min: 3);
    final to = faker.randomGenerator.string(3, min: 3);
    final amount = faker.randomGenerator.decimal(scale: 10);
    params = ConversionParamsModel(from: from, to: to, amount: amount);
  });

  group("ConvertController", () {
    test(
        "When calling convert method, should call convertUsecase with correct parameters",
        () async {
      // arrange

      when(() => convertUsecase(conversionParamsEntity: params))
          .thenAnswer((_) async => Right(ConversionModel(result: 0, rate: 0)));

      // act
      sut.convert(params);
      // assert

      verify(() => convertUsecase(conversionParamsEntity: params)).called(1);
    });

    test(
        "When calls convert method, and usecase return Left, should change state to loadstate than error state",
        () async {
      when(() => convertUsecase(conversionParamsEntity: params))
          .thenAnswer((_) async => Left(ConnectionFailure("")));

      expect(
          sut,
          emitValues([
            isA<ConvertLoadingState>(),
            isA<ConvertErrorState>(),
          ]));

      await sut.convert(params);
    });

    test(
        "When calls convert method, and usecase return Right, should change state to loadstate than success state",
        () async {
      when(() => convertUsecase(conversionParamsEntity: params))
          .thenAnswer((_) async => Right(ConversionModel(result: 0, rate: 0)));

      expect(
          sut,
          emitValues([
            isA<ConvertLoadingState>(),
            isA<ConvertSuccessState>(),
          ]));

      await sut.convert(params);
    });
  });
}
