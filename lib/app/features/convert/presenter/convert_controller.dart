import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_params_entity.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/domain/usecases/convert_usecase.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/states/convert_states.dart';
import 'package:flutter/material.dart';

class ConvertController extends ValueNotifier<ConvertState> {
  final ConvertUsecase convertUsecase;

  ConvertController({required this.convertUsecase})
      : super(const ConvertInitialState());

  Future<void> convert(ConversionParamsEntity conversionParamsEntity) async {
    value = const ConvertLoadingState();
    final result =
        await convertUsecase(conversionParamsEntity: conversionParamsEntity);

    result.fold((l) {
      value = ConvertErrorState(l);
    }, (r) {
      value = ConvertSuccessState(r);
    });
  }
}
