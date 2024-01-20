import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riddle_me/logic/ad_bloc/ad_bloc.dart';
import 'package:riddle_me/logic/riddles_bloc/riddles_bloc.dart';
import 'package:riddle_me/router/router.dart';
import 'package:sizer/sizer.dart';

import 'logic/config_bloc/config_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  _setTestDeviceId();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiBlocProvider(providers: [
        BlocProvider<ConfigBloc>(
          create: (context) => ConfigBloc(),
        ),
        BlocProvider<RiddlesBloc>(
          create: (context) => RiddlesBloc(),
        ),
        BlocProvider<AdBloc>(
          create: (context) => AdBloc(riddlesBloc: context.read<RiddlesBloc>()),
        ),
      ], child: const MyApp()), // Wrap your app
    ),
  );
}

void _setTestDeviceId() {
  RequestConfiguration configuration = RequestConfiguration(
    testDeviceIds: ['202CC44703328E4EC87F7BB14496B9D5'],
  );
  MobileAds.instance.updateRequestConfiguration(configuration);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff451699),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              chipTheme: ChipThemeData(
                labelStyle: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.pink,
                  fontFamily: "BubblegumSans",
                ),
              ),
              textTheme: TextTheme(
                headlineLarge: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "BubblegumSans",
                  color: Colors.black,
                ),
                headlineMedium: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "BubblegumSans",
                  color: Colors.black,
                ),
                headlineSmall: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "BubblegumSans",
                  color: Colors.black,
                ),
                bodyLarge: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: "BubblegumSans",
                  color: Colors.black,
                ),
                bodyMedium: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: "BubblegumSans",
                  color: Colors.black,
                ),
                bodySmall: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  fontFamily: "BubblegumSans",
                  color: Colors.black,
                ),
              )),
        );
      },
    );
  }
}
