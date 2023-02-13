import 'package:currency_convert_tdd_practice/app/features/convert/presenter/convert_controller.dart';
import 'package:currency_convert_tdd_practice/app/features/convert/presenter/widgets/convert_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ConvertPage extends StatefulWidget {
  final ConvertController convertController;
  final String to;
  final String from;
  const ConvertPage(
      {Key? key,
      required this.convertController,
      required this.to,
      required this.from})
      : super(key: key);

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  @override
  void initState() {
    super.initState();
    widget.convertController.to = widget.to;
    widget.convertController.from = widget.from;
  }

  @override
  void dispose() {
    GetIt.I.resetLazySingleton<ConvertController>();
    FocusManager.instance.primaryFocus?.unfocus();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF8663F3),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.currency_exchange_rounded,
                    color: Colors.white, size: 40),
                Text(
                  'Converter',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            ConvertFormWidget(
                                convertController: widget.convertController),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Color(0xFFF50057),
                                      ),
                                    ),
                                    child: const Text(
                                      "GO BACK",
                                      style: TextStyle(
                                        color: Color(0xFFF50057),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/icon_page_2.png",
                      height: 250,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
