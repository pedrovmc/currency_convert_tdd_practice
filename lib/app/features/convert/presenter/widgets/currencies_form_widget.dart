import 'package:currency_convert_tdd_practice/app/features/convert/presenter/select_currencies_controller.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/states/get_currencies_states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrenciesFormWidget extends StatelessWidget {
  const CurrenciesFormWidget({
    Key? key,
    required this.selectCurrenciesController,
  }) : super(key: key);

  final SelectCurrenciesController selectCurrenciesController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectCurrenciesController.state,
      builder: (context, state, child) {
        if (state is GetCurrenciesSuccessState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From:",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade100,
                      child: ValueListenableBuilder(
                        valueListenable:
                            selectCurrenciesController.dropDown1Value,
                        builder: (context, value, child) {
                          return DropdownButton<String>(
                            value: value,
                            isExpanded: true,
                            underline: const SizedBox(),
                            onChanged: (String? newValue) {
                              selectCurrenciesController.dropDown1Value.value =
                                  newValue!;
                            },
                            items: state.currencies
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.code,
                                    child: Text(
                                      e.code,
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TO:",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade100,
                      child: ValueListenableBuilder(
                        valueListenable:
                            selectCurrenciesController.dropDown2Value,
                        builder: (context, value, _) {
                          return DropdownButton<String>(
                            value: value,
                            underline: const SizedBox(),
                            isExpanded: true,
                            onChanged: (String? newValue) {
                              selectCurrenciesController.dropDown2Value.value =
                                  newValue!;
                            },
                            items: state.currencies
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.code,
                                    child: Text(
                                      e.code,
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Text("Loading...");
        }
      },
    );
  }
}
