import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/core/constants/images.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text.dart';

class NoRoutesScreen extends StatelessWidget {
  const NoRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightScaffoldBgColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: SvgPicture.asset(
                AppAssetImages.appLogo,
                semanticsLabel: "Text",
                width: 150,
                height: 40,
              ),
            ),
            const SizedBox(height: 20),
            TextCustomWidgets.headingTextWidget(
              title: "No Routes Available",
            ),
          ],
        ),
      ),
    );
  }
}
