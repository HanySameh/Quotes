import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:quotes/core/widgets/error_widget.dart' as error_widget;

import '../../../../core/utilities/app_colors.dart';
import '../cubit/random_quote_cubit.dart';
import '../cubit/random_quote_states.dart';
import '../widgets/quote_content.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote() =>
      BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
      builder: ((context, state) {
        if (state is RandomQuoteIsLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        } else if (state is RandomQuoteError) {
          return error_widget.ErrorWidget(
            onPress: () => _getRandomQuote(),
          );
        } else if (state is RandomQuoteLoaded) {
          return Column(
            children: [
              QuoteContent(
                quote: state.quote,
              ),
              InkWell(
                  onTap: () => _getRandomQuote(),
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
                  ))
            ],
          );
        } else {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.translate_outlined,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
          title: const Text('Quote'),
        ),
        body: _buildBodyContent(),
      ),
      onRefresh: () => _getRandomQuote(),
    );
  }
}
