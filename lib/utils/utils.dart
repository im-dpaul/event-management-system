import 'package:event_management_system/utils/shared/constants.dart';
import 'package:event_management_system/utils/shared/styles.dart';
import 'package:flutter/material.dart';

class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  showSnackBar(
      {required BuildContext context, required String content, Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 3000),
        backgroundColor: (color != null) ? color : snackbarColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        content: SizedBox(
          width: getScreenSize().width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                overflow: TextOverflow.ellipsis,
                style: styleRegular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
