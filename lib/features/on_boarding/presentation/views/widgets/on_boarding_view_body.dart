import 'package:car_project/features/on_boarding/presentation/views/widgets/on_boarding_page_view.dart';
import 'package:flutter/material.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_texts.dart';
import '../../../../../core/widgets/general_button.dart';
import 'custom_dots_indicators.dart';
import 'row_buttons.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // page view and page view item
        SizedBox(
          child: OnBoardingPageView(
            controller: pageController,
          ),
        ),
        // custom dots indicators اللي هما ال3 نقط اللي بيتحركوا معانا منش الشاشة والتانية
        // we used media query to get the height of the screen to make it responsive
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.2,
          right: 10,
          left: 10,
          child: CustomDotsIndicators(
            dotIndex:
                pageController.hasClients ? pageController.page!.round() : 0,
          ),
        ),
        // we used media query to get the height of the screen to make it responsive
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.05,
          right: 10,
          left: 10,
          child: pageController.hasClients && pageController.page! > 1
              ? GeneralButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.loginOrRegister);
                  },
                  text: AppTexts.letsStart,
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                )
              : RowButtons(pageController: pageController),
        ),
      ],
    );
  }
}
