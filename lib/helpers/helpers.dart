import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'assets_provider.dart';
import '../theme/theme.dart';

Widget showCheckIcon(bool isValid, BuildContext context) {
  if (isValid) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ZoomIn(
          duration: const Duration(milliseconds: 200),
          child: SvgPicture.asset(
            AssetsProvider.valid,
            color: Theme.of(context).colorScheme.validColor,
          )),
    );
  }
  return Container();
}

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

class Nothing {
  const Nothing();
}

var maskFormatter = MaskTextInputFormatter(
    mask: "###-####-###'",
    filter: {'#': RegExp(r'[A-Z0-9]')},
    type: MaskAutoCompletionType.lazy);
