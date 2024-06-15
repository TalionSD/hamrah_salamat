import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';

void showSnackBar(
  BuildContext context, {
  required String message,
  required SnackBarType snackbarType,
  String? textButton,
  void Function()? onTap,
}) {
  Flushbar(
    textDirection: TextDirection.rtl,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,

    // message: message,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: snackbarType == SnackBarType.error ? Theme.of(context).colorScheme.error : Theme.of(context).primaryColor,

    isDismissible: true,
    duration: const Duration(seconds: 4),
    borderRadius: BorderRadius.circular(10),

    margin: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width / 40,
      vertical: MediaQuery.of(context).size.height / 50,
    ),
    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 50, horizontal: MediaQuery.of(context).size.width / 50),

    showProgressIndicator: false,

    messageText: Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 70),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: snackbarType == SnackBarType.success ? const Color.fromARGB(255, 216, 239, 217) : const Color.fromARGB(255, 239, 216, 216),
              ),
              child: Icon(
                snackbarType == SnackBarType.success ? Icons.check : Icons.close,
                color: snackbarType == SnackBarType.error ? Theme.of(context).colorScheme.error : Theme.of(context).primaryColor,
              ),
            ),
          ),
          Flexible(
            flex: onTap != null ? 7 : 10,
            fit: FlexFit.tight,
            child: Text(
              message,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          if (onTap != null)
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 50,
                    vertical: MediaQuery.of(context).size.height / 200,
                  ),
                  decoration: BoxDecoration(
                    // color: AppStyles.accentColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textButton!,
                        // style: AppStyles.text.copyWith(color: AppStyles.backgroundColor, fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        // color: AppStyles.backgroundColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  ).show(context);
}
