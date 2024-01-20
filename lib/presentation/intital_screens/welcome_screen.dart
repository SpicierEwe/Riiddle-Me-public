import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:riddle_me/constants/string_constants.dart';
import 'package:riddle_me/constants/variable_constants.dart';
import 'package:riddle_me/logic/config_bloc/config_bloc.dart';
import 'package:riddle_me/logic/config_bloc/config_bloc.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, configState) {
          return Column(
            children: [
              const Expanded(
                child: Image(
                  image: AssetImage('assets/images/hero.png'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0;
                            i < VariableConstants.riddleAdvantages.length;
                            i++)
                          Column(
                            children: [
                              // name
                              Text(
                                VariableConstants.riddleAdvantages[i]
                                    ["titles"]!,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.16),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: AssetImage(VariableConstants
                                          .riddleAdvantages[i]["image"]!),
                                      height: 9.h,
                                      width: 17.w,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    // icon name
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Text(VariableConstants
                                            .riddleAdvantages[i]["name"]!),
                                        Visibility(
                                          visible:
                                              configState.areIconNamesMasked,
                                          child: Container(
                                            color: Colors.grey,
                                            height: 3.5.h,
                                            width: 17.w,
                                            // Set the color to match your background
                                            alignment: Alignment.center,
                                            child: Text(
                                              "?",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    // this is the reveal button and the question
                    if (configState.areIconNamesMasked)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                // Question 1
                                Text(
                                  StringConstants.welcomeScreenQuestion1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                // Stack for Pulsating Circle and Reveal Button

                                // Reveal Button
                                // if (configState.areIconNamesMasked)
                                TextButton(
                                  onPressed: () async {
                                    context
                                        .read<ConfigBloc>()
                                        .add(RevealIconsNamesEvent());
                                  },
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/images/reveal_button.png'),
                                    height: 19.h,
                                    width: 50.w,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    if (!configState.areIconNamesMasked)
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              // Question 2
                              Text(
                                StringConstants.welcomeScreenQuestion2,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              // Well done
                              Text(
                                "Well Done!",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              // Stack for Pulsating Circle and Reveal Button

                              // Reveal Button
                              // if (configState.areIconNamesMasked)
                              // Lets GOOO!! Button

                              Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      context
                                          .read<ConfigBloc>()
                                          .add(HasSeenInitialScreensEvent());
                                      context.replace('/home');
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "LETS GOO!  ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                          const WidgetSpan(
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ))
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
