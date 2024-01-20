import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riddle_me/constants/variable_constants.dart';
import 'package:riddle_me/data/riddles.dart';
import 'package:riddle_me/logic/ad_bloc/ad_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../logic/riddles_bloc/riddles_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<RiddlesBloc>().add(NewRiddleEvent());
    context.read<RiddlesBloc>().add(InitializePointsAndUserAvailableHints());
    context.read<AdBloc>().add(DisplayBannerAdEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AdBloc, AdState>(
          builder: (context, adState) {
            return BlocBuilder<RiddlesBloc, RiddlesState>(
              builder: (context, riddlesState) {
                final String riddleQuestion = RiddlesDb
                    .riddlesList[riddlesState.randomRiddleIndex]["question"]!;
                final String riddleAnswer = RiddlesDb
                    .riddlesList[riddlesState.randomRiddleIndex]["answer"]!;
                return Column(
                  children: <Widget>[
                    if (adState.bannerAd != null)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SafeArea(
                          child: SizedBox(
                            width: adState.bannerAd!.size.width.toDouble(),
                            height: adState.bannerAd!.size.height.toDouble(),
                            child: AdWidget(ad: adState.bannerAd!),
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.5.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              // color: const Color(0xffe00ca0),
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'RIDDLE ME',
                              // ' ${riddlesState.randomRiddleIndex}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Row(
                            children: [
                              Text(
                                'points : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                // Adjust padding as needed
                                decoration: BoxDecoration(
                                  color: riddlesState.points <= 1
                                      ? Colors.red
                                      : riddlesState.points > 1 &&
                                              riddlesState.points <= 3
                                          ? Colors.orange
                                          : Colors.green,
                                  // Set the color to green
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Optional: Add rounded corners
                                ),
                                child: Text(
                                  riddlesState.points.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<AdBloc>()
                                      .add(EarnPointsAdEvent());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView(
                        padding: EdgeInsets.only(bottom: 1.h),
                        children: [
                          // riddle question
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 3.h),
                            child: Text(
                              riddleQuestion,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 20.sp,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 5.w,
                                  right: 5.w,
                                  bottom: 2.h,
                                  top: 1.h,
                                ),
                                child: Text(
                                  "What am i?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: Colors.teal,
                                      ),
                                ),
                              ),

                              Stack(
                                children: [
                                  Text(
                                    riddleAnswer,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(),
                                  ),
                                  Visibility(
                                    visible: !riddlesState.isRiddleRevealed,
                                    child: Positioned.fill(
                                      child: Container(
                                        // duration: Duration(milliseconds: 500),
                                        color: Colors.grey,
                                        child: Text(
                                          "?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              //   hints

                              Visibility(
                                visible: riddlesState.takenHints > 0,
                                child: Column(
                                  children: [
                                    SizedBox(height: 2.h),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Hints :",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                color: Colors.teal,
                                              ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Wrap(
                                      spacing: 5.w,
                                      children: [
                                        for (int i = 0;
                                            i <
                                                VariableConstants
                                                    .hintsList.length;
                                            i++)
                                          Visibility(
                                            visible:
                                                riddlesState.takenHints > i,
                                            child: Chip(
                                                elevation: 1,
                                                label: Text(VariableConstants
                                                        .hintsList[i]
                                                    ["function"](riddleAnswer)),
                                                backgroundColor:
                                                    VariableConstants
                                                        .hintsList[i]["color"],
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                )),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    // bottom buttons
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ====================== hint  button =====================
                          // =========================  // =====================
                          TextButton(
                            onPressed: () => riddlesState.isRiddleRevealed
                                ? null
                                : context
                                    .read<RiddlesBloc>()
                                    .add(TakeHintEvent()),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: riddlesState.isRiddleRevealed
                                        ? Colors.grey
                                        : Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: Text(
                              'hint? (${riddlesState.usersAvailableHints})',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: riddlesState.isRiddleRevealed
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                            ),
                          ),
                          //   ================ reveal button =====================
                          TextButton(
                            onPressed: () => riddlesState.isRiddleRevealed
                                ? null
                                : context
                                    .read<RiddlesBloc>()
                                    .add(RevealRiddleEvent()),
                            child: Image.asset(
                              riddlesState.isRiddleRevealed
                                  ? VariableConstants.revealedButtonImageLink
                                  : VariableConstants.revealButtonImageLink,
                              width: 35.w,
                            ),
                          ),

                          // next button
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                riddlesState.isRiddleRevealed
                                    ? const Color(0xffe00ca0)
                                    : Colors.grey,
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (!riddlesState.isRiddleRevealed) {
                                return;
                              }

                              context
                                  .read<AdBloc>()
                                  .add(DisplayInterstitialAdEvent());
                              //
                              context.read<RiddlesBloc>().add(NewRiddleEvent());
                              context
                                  .read<RiddlesBloc>()
                                  .add(InitializePointsAndUserAvailableHints());
                            },
                            child: Text(
                              'NEXT',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
