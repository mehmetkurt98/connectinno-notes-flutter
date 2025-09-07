import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injection_container.dart';
import 'core/utils/constants.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          kIsWeb
              ? const Size(1920, 1080)
              : const Size(375, 812), // Web için büyük, mobil için standart
      minTextAdapt: false, // Web'de metinleri küçültme
      splitScreenMode: false, // Web'de split screen gereksiz
      useInheritedMediaQuery: true, // Web'de media query kullan
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(authRepository: sl()),
            ),
          ],
          child: MaterialApp.router(
            title: AppConstants.appName,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // Web için responsive ayarlar
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(
                    kIsWeb ? 1.2 : 1.0, // Web'de text scaling'i biraz artır
                  ),
                ),
                child:
                    kIsWeb
                        ? Center(
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 600,
                            ), // Web'de max genişlik
                            child: child!,
                          ),
                        )
                        : child!,
              );
            },
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
