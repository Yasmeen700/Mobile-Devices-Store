import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressDialog {
  bool isShowing = false;
  void hide() {
    Get.back();
  }

  BuildContext? dialogContext;
  void show({required BuildContext context, required String message}) {
    isShowing = true;
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return WillPopScope(
          onWillPop: () async {
            isShowing = false;
            return false;
          },
          child: Dialog(
            insetAnimationCurve: Curves.easeInOut,
            insetAnimationDuration: const Duration(milliseconds: 100),
            elevation: 10.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: SizedBox(
              height: 80.0,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 15.0),
                  const SizedBox(
                    width: 32.0,
                    height: 32.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: Text(message,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
