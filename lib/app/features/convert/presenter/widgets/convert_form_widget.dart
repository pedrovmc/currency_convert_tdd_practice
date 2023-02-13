import 'package:currency_convert_tdd_practice/app/features/convert/infra/models/conversion_params_model.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/convert_controller.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/states/convert_states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConvertFormWidget extends StatelessWidget {
  ConvertFormWidget({
    Key? key,
    required this.convertController,
  }) : super(key: key);

  final ConvertController convertController;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: convertController,
      builder: (context, state, child) {
        if (state is! ConvertLoadingState) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${convertController.from} amount:",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                  ),
                ),
                Container(
                    color: Colors.grey.shade100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _controller,
                    )),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          convertController.convert(ConversionParamsModel(
                              from: convertController.from,
                              to: convertController.to,
                              amount: double.parse(_controller.text)));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFFF50057),
                          ),
                        ),
                        child: const Text(
                          "CONVERT",
                        ),
                      ),
                    ),
                  ],
                ),
                Builder(builder: (_) {
                  if (state is ConvertSuccessState) {
                    return Center(
                        child:
                            Text("Result: ${state.conversionEntity.result}"));
                  } else {
                    return const SizedBox();
                  }
                })
              ],
            ),
          );
        } else {
          return const Text("Loading...");
        }
      },
    );
  }
}
