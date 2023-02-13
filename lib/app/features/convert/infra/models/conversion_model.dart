import 'package:currency_convert_tdd_practice/app/features/convert/domain/entities/conversion_entity.dart';
import 'package:equatable/equatable.dart';

class ConversionModel extends ConversionEntity with EquatableMixin {
  ConversionModel({required super.result, required super.rate});

  @override
  List<Object?> get props => [
        result,
        rate,
      ];

  factory ConversionModel.fromMap(Map<String, dynamic> map) {
    return ConversionModel(
      result: double.parse(map["conversion_result"].toString()),
      rate: double.parse(map["conversion_rate"].toString()),
    );
  }
}
