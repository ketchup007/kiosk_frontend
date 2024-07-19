import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/country_model.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/buttons/num_pad.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';

class PhonePopupCard extends StatefulWidget {
  final Function onPress;
  final Function onInteraction;

  const PhonePopupCard({Key? key, required this.onPress, required this.onInteraction}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhonePopupCardState();
}

class _PhonePopupCardState extends State<PhonePopupCard> {
  bool isCheckedMain = false;
  bool isCheckedA = false;
  bool isCheckedB = false;
  bool isCheckedC = false;

  bool changeMainPerformed = false;
  bool changeAPerformed = false;
  bool changeBPerformed = false;
  bool changeCPerformed = false;

  final TextEditingController _myController = TextEditingController();

  CountryModel _dropdownValue = CountryModel(countryCode: "", dialCode: "", minNumber: 0, maxNumber: 0, format: "");

  late MainProvider provider;

  void onPointerDown(PointerDownEvent event) {
    //print("dumpc");
    widget.onInteraction();
  }

  @override
  initState() {
    super.initState();
  }

  void changeMain() {
    setState(() {
      isCheckedMain = !isCheckedMain;
      if (isCheckedMain) {
        isCheckedA = true;
        isCheckedB = true;
        isCheckedC = true;
      } else {
        isCheckedA = false;
        isCheckedB = false;
        isCheckedC = false;
      }
    });
  }

  void changeA() {
    setState(() {
      isCheckedA = !isCheckedA;
      if (isCheckedA == true && isCheckedB == true && isCheckedC == true) {
        isCheckedMain = true;
      } else {
        isCheckedMain = false;
      }
    });
  }

  void changeB() {
    setState(() {
      isCheckedB = !isCheckedB;

      if (isCheckedA == true && isCheckedB == true && isCheckedC == true) {
        isCheckedMain = true;
      } else {
        isCheckedMain = false;
      }
    });
  }

  void changeC() {
    setState(() {
      isCheckedC = !isCheckedC;
      if (isCheckedA == true && isCheckedB == true && isCheckedC == true) {
        isCheckedMain = true;
      } else {
        isCheckedMain = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);

    bool isBiggerThan1000 = MediaQuery.of(context).size.height > 1000;

    if (provider.countryList.isEmpty) {
      provider.getCountryCodes();
      return const Text("");
    } else {
      if (_dropdownValue.dialCode.isEmpty) {
        _dropdownValue = provider.countryList.first;
      }
      return Listener(
        onPointerDown: onPointerDown,
        child: Center(
          child: SizedBox(
            height: isBiggerThan1000 ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      isBiggerThan1000 ? MediaQuery.of(context).size.height * 0.01 : MediaQuery.of(context).size.height * 0.02,
                      0,
                      isBiggerThan1000 ? MediaQuery.of(context).size.width * 0 : MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: SizedBox(
                      width: isBiggerThan1000 ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.7,
                      child: FittedBox(
                        child: Text(
                          AppText.current.enterPhoneNumberText.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: "GloryMedium",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(isBiggerThan1000 ? MediaQuery.of(context).size.width * 0.03 : MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
                        alignment: Alignment.bottomCenter,
                        child: DropdownButton(
                          value: _dropdownValue,
                          iconSize: isBiggerThan1000 ? 20 : 10,
                          items: provider.countryList.map<DropdownMenuItem<CountryModel>>((CountryModel value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0, 0, 0, MediaQuery.of(context).size.width * 0.005),
                                child: SizedBox(
                                  height: isBiggerThan1000 ? MediaQuery.of(context).size.height * 0.02 : MediaQuery.of(context).size.height * 0.05,
                                  width: isBiggerThan1000 ? MediaQuery.of(context).size.width * 0.12 : MediaQuery.of(context).size.width * 0.21,
                                  child: Text(
                                    "${value.countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'), (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397))} ${value.dialCode}",
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: isBiggerThan1000 ? 20 : 22,
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
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.04, 0, 0, isBiggerThan1000 ? MediaQuery.of(context).size.height * 0.005 : MediaQuery.of(context).size.height * 0.01),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                          width: isBiggerThan1000 ? MediaQuery.of(context).size.width * 0.45 : MediaQuery.of(context).size.width * 0.5,
                          child: AutoSizeTextField(
                            controller: _myController,
                            showCursor: false,
                            keyboardType: TextInputType.none,
                            minFontSize: isBiggerThan1000 ? 20 : 30,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: MediaQuery.of(context).size.height * 0.1,
                              fontFamily: 'GloryBold',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.02,
                      0,
                      isBiggerThan1000 ? MediaQuery.of(context).size.height * 0.02 : MediaQuery.of(context).size.height * 0.04,
                    ),
                    child: Center(
                      child: NumPad(
                        controller: _myController,
                        maxDigit: _dropdownValue.maxNumber,
                        buttonSize: isBiggerThan1000 ? MediaQuery.of(context).size.width * 0.14 : MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: isBiggerThan1000 ? MediaQuery.of(context).size.height * 0.03 : MediaQuery.of(context).size.height * 0.05,
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: InkWell(
                                        onTapDown: (_) {
                                          changeMain();
                                          changeMainPerformed = true;
                                        },
                                        onTapCancel: () {
                                          changeMainPerformed = false;
                                        },
                                        child: Checkbox(
                                            activeColor: AppColors.green,
                                            checkColor: Colors.transparent,
                                            side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 1.5, color: AppColors.green)),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                            value: isCheckedMain,
                                            onChanged: (_) {
                                              if (changeMainPerformed) {
                                                changeMainPerformed = false;
                                              } else {
                                                changeMain();
                                              }
                                            }),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTapDown: (_) {
                                        changeMain();
                                      },
                                      child: Text(
                                        AppText.current.selectAllCheckText,
                                        style: const TextStyle(
                                          fontFamily: "GloryMedium",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isBiggerThan1000 ? MediaQuery.of(context).size.height * 0.03 : MediaQuery.of(context).size.height * 0.05,
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Transform.scale(
                                        scale: 1.5,
                                        child: InkWell(
                                          onTapDown: (_) {
                                            changeA();
                                            changeAPerformed = true;
                                          },
                                          onTapCancel: () {
                                            changeAPerformed = false;
                                          },
                                          child: Checkbox(
                                              activeColor: AppColors.green,
                                              checkColor: Colors.transparent,
                                              side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 1.5, color: AppColors.green)),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                              value: isCheckedA,
                                              onChanged: (_) {
                                                if (changeAPerformed) {
                                                  changeAPerformed = false;
                                                } else {
                                                  changeA();
                                                }
                                              }),
                                        )),
                                    GestureDetector(
                                      onTapDown: (_) {
                                        changeA();
                                      },
                                      child: Text(
                                        AppText.current.requiredCheckText,
                                        style: const TextStyle(
                                          fontFamily: "GloryMedium",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isBiggerThan1000 ? MediaQuery.of(context).size.height * 0.03 : MediaQuery.of(context).size.height * 0.05,
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: InkWell(
                                        onTapDown: (_) {
                                          changeB();
                                          changeBPerformed = true;
                                        },
                                        onTapCancel: () {
                                          changeBPerformed = false;
                                        },
                                        child: Checkbox(
                                            activeColor: AppColors.green,
                                            checkColor: Colors.transparent,
                                            side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 1.5, color: AppColors.green)),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                            value: isCheckedB,
                                            onChanged: (_) {
                                              if (changeBPerformed) {
                                                changeBPerformed = false;
                                              } else {
                                                changeB();
                                              }
                                            }),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTapDown: (_) {
                                        changeB();
                                      },
                                      child: Text(
                                        AppText.current.promotionCheckText,
                                        style: const TextStyle(
                                          fontFamily: "GloryMedium",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: isBiggerThan1000 ? MediaQuery.of(context).size.height * 0.03 : MediaQuery.of(context).size.height * 0.05,
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: InkWell(
                                        onTapDown: (_) {
                                          changeC();
                                          changeCPerformed = true;
                                        },
                                        child: Checkbox(
                                            activeColor: AppColors.green,
                                            checkColor: Colors.transparent,
                                            side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 1.5, color: AppColors.green)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            value: isCheckedC,
                                            onChanged: (_) {
                                              if (changeCPerformed) {
                                                changeCPerformed = false;
                                              } else {
                                                changeC();
                                              }
                                            }),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTapDown: (_) {
                                        changeC();
                                      },
                                      child: Text(
                                        AppText.current.optionalCheckText,
                                        style: const TextStyle(
                                          fontFamily: "GloryMedium",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.035, MediaQuery.of(context).size.width * 0.05, 0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton(
                            onPressed: () {
                              if (isCheckedA == true && _myController.text.length >= _dropdownValue.minNumber) {
                                Navigator.of(context).pop();
                                provider.order = provider.order.copyWith(clientPhoneNumber: _dropdownValue.dialCode + _myController.text);
                                widget.onPress(isCheckedB);
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                            child: AutoSizeText(
                              AppText.current.confirmButtonLabel,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'GloryBold',
                                fontSize: isBiggerThan1000 ? 30 : 15,
                              ),
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
      );
    }
  }
}
