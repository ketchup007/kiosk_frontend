import 'package:flutter/material.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/models/country_model.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/login_code_screen.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:provider/provider.dart';

import '../themes/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  CountryModel _dropdownValue = CountryModel(countryCode: "", dialCode: "", minNumber: 0, maxNumber: 0, format: "");

  @override
  Widget build(context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    if (provider.countryList.isEmpty) {
      provider.getCountryCodes();
      return const Text("");
    } else {
      if (_dropdownValue.dialCode.isEmpty) {
        _dropdownValue = provider.countryList.first;
      }

      return Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: LanguageButtons(ribbonHeight: MediaQuery.of(context).size.height * 0.1, ribbonWidth: MediaQuery.of(context).size.width * 0.1)),
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
            const Text("na podany nr zostanie wysłany kod potrzebny do zalogowania", textAlign: TextAlign.center),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: DropdownButton(
                    value: _dropdownValue,
                    iconSize: 10,
                    items: provider.countryList.map<DropdownMenuItem<CountryModel>>((CountryModel value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0, 10, 0, MediaQuery.of(context).size.width * 0.005),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.23,
                            child: Text(
                              "${value.countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'), (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397))} ${value.dialCode}",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height > 1000 ? 20 : 22,
                                fontFamily: 'GloryBold',
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (CountryModel? value) {
                      setState(() {
                        _dropdownValue = value!;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      maxLength: _dropdownValue.maxNumber,
                      keyboardType: TextInputType.number,
                      controller: loginController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Numer Telefonu",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                onPressed: () {
                  if (loginController.text.length >= _dropdownValue.minNumber) {
                    print("login: ${_dropdownValue.dialCode} ${loginController.text}");
                    ApiService(token: provider.loginToken).smsLogin(_dropdownValue.dialCode + loginController.text, url: ApiConstants.baseUrl).then((value) {
                      if (value == "SMS_SEND") {
                        provider.phoneNumber = _dropdownValue.dialCode + loginController.text;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginCodeScreen()));
                      }
                    });
                  }
                },
                child: const Text("Wyślij SMS"),
              ),
            ),
          ],
        ),
      );
    }
  }
}
