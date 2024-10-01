import 'package:flutter/material.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/login_code_screen.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:provider/provider.dart';
import '../themes/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = PhoneController(initialValue: const PhoneNumber(isoCode: IsoCode.PL, nsn: ''));
  final FocusNode phoneFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: LanguageButtons(
              ribbonHeight: MediaQuery.of(context).size.height * 0.1,
              ribbonWidth: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: const Text(
                    "Aby się zalogować podaj numer telefonu",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: "GloryBold",
                    ),
                  ),
                ),
                const Text(
                  "na podany nr zostanie wysłany kod potrzebny do zalogowania",
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Form(
                    key: formKey,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: PhoneFormField(
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        countrySelectorNavigator: const CountrySelectorNavigator.bottomSheet(
                          favorites: [IsoCode.PL, IsoCode.GB, IsoCode.UA],
                        ),
                        validator: PhoneValidator.compose([
                          PhoneValidator.validMobile(context),
                        ]),
                        decoration: const InputDecoration(
                          labelText: 'Numer Telefonu',
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final phoneNumber = phoneController.value.international;
                        ApiService(token: provider.loginToken).smsLogin(phoneNumber, url: ApiConstants.baseUrl).then((value) {
                          if (value == "SMS_SEND") {
                            provider.phoneNumber = phoneNumber;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginCodeScreen(),
                              ),
                            );
                          }
                        });
                      }
                    },
                    child: const Text(
                      "Wyślij SMS",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }
}
