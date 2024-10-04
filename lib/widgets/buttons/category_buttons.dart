import 'package:flutter/material.dart';
import 'package:kiosk_flutter/themes/color.dart';

class CategoryButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onPressed;
  final int number;
  final String text;

  const CategoryButton({
    super.key,
    required this.selected,
    required this.onPressed,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTapDown: (_) => onPressed(),
      child: Container(
        height: selected ? screenHeight * 0.08 : screenHeight * 0.07,
        width: screenWidth * 0.133,
        padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.01, 0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            foregroundColor: WidgetStateProperty.resolveWith((states) => Colors.white),
            backgroundColor: WidgetStateProperty.resolveWith((states) => selected ? AppColors.mediumBlue : AppColors.lightBlue),
            shape: WidgetStateProperty.resolveWith(
              (states) => const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
            ),
            elevation: WidgetStateProperty.resolveWith((states) => 0.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: screenWidth * 0.06,
                    width: screenWidth * 0.06,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.darkBlue),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          "$number",
                          style: TextStyle(
                            color: selected ? Colors.white : AppColors.lightBlue,
                            fontFamily: 'GloryExtraBold',
                            fontSize: 45,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
                  child: SizedBox(
                    height: screenHeight * 0.02,
                    width: screenWidth * 0.17,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: selected ? Colors.white : AppColors.darkBlue,
                          fontFamily: selected ? 'GloryExtraBold' : 'GloryMedium',
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EdgeCategoryButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onPressed;
  final int number;
  final String text;

  const EdgeCategoryButton({
    super.key,
    required this.selected,
    required this.onPressed,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        InkWell(
          onTapDown: (_) => onPressed(),
          child: Container(
            height: screenHeight * 0.08,
            width: screenWidth * 0.18,
            padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.01, 0),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                foregroundColor: WidgetStateProperty.resolveWith((states) => Colors.white),
                backgroundColor: WidgetStateProperty.resolveWith((states) => selected ? AppColors.mediumBlue : AppColors.lightBlue),
                shape: WidgetStateProperty.resolveWith(
                  (states) => const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                ),
                elevation: WidgetStateProperty.resolveWith((states) => 0.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        height: screenWidth * 0.06,
                        width: screenWidth * 0.06,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.darkBlue),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              "$number",
                              style: TextStyle(
                                color: selected ? Colors.white : AppColors.lightBlue,
                                fontFamily: 'GloryExtraBold',
                                fontSize: 45,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 8.0 + (selected ? 0 : screenHeight * 0.01),
                        left: 4.0,
                        right: 4.0,
                      ),
                      child: SizedBox(
                        height: screenHeight * 0.02,
                        width: screenWidth * 0.17,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: selected ? Colors.white : AppColors.darkBlue,
                              fontFamily: selected ? 'GloryExtraBold' : 'GloryMedium',
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: !selected,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, screenHeight * 0.07, 0, 0),
            child: Container(
              width: screenWidth * 0.17,
              height: screenHeight * 0.05,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SummaryButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onPressed;
  final int number;
  final String text;

  const SummaryButton({
    super.key,
    required this.selected,
    required this.onPressed,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(children: [
      InkWell(
        onTapDown: (_) {
          onPressed();
        },
        child: Container(
          height: screenHeight * 0.08,
          width: screenWidth * 0.18,
          padding: EdgeInsets.fromLTRB(0, 0, screenWidth * 0.01, 0),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              foregroundColor: WidgetStateProperty.resolveWith((states) => Colors.white),
              backgroundColor: WidgetStateProperty.resolveWith((states) => AppColors.green),
              shape: WidgetStateProperty.resolveWith(
                (states) => const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
              ),
              elevation: WidgetStateProperty.resolveWith((states) => 0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      height: screenWidth * 0.06,
                      width: screenWidth * 0.06,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.darkGreen),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            "$number",
                            style: TextStyle(
                              color: selected ? Colors.white : AppColors.lightBlue,
                              fontFamily: 'GloryExtraBold',
                              fontSize: 45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 8.0 + (selected ? 0 : screenHeight * 0.01),
                      left: 4.0,
                      right: 4.0,
                    ),
                    child: SizedBox(
                      height: screenHeight * 0.02,
                      width: screenWidth * 0.17,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            color: selected ? Colors.white : AppColors.darkGreen,
                            fontFamily: selected ? 'GloryExtraBold' : 'GloryMedium',
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Visibility(
        visible: !selected,
        maintainState: true,
        maintainSize: true,
        maintainAnimation: true,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, screenHeight * 0.07, 0, 0),
          child: Container(
            width: screenWidth * 0.17,
            height: screenHeight * 0.05,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
