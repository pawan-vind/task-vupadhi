import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/constants/teststyling.dart';

class LogInTopSection extends StatelessWidget {
  const LogInTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AppAssetImages.appLogo),
        const SizedBox(height: 20),
        Text(
          'Login',
          style: AppStyling.headingStylePurpleF20Bold(
              fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
