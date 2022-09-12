import 'package:flutter/material.dart';
import 'package:quotes/core/utilities/app_strings.dart';
import 'package:quotes/features/random_quote/presentation/widgets/quote_content.dart';

import '../../../../core/utilities/app_colors.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Column(
        children: [
          const QuoteContent(),
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: const Icon(
                Icons.refresh,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
