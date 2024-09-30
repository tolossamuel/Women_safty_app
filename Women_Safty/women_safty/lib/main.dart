import 'package:device_preview/device_preview.dart';

import 'package:flutter/material.dart';
import 'package:women_safty/futures/admin/presentation/state/admin_bloc.dart';
import 'package:women_safty/futures/admin/presentation/ui/admin_list.dart';
import 'package:women_safty/futures/admin/presentation/ui/admin_page.dart';
import 'package:women_safty/futures/admin/presentation/ui/gardian_list.dart';
import 'package:women_safty/futures/auth/presentation/UI/admin_login.dart';
import 'package:women_safty/futures/auth/presentation/UI/guardian_login.dart';
import 'package:women_safty/futures/auth/presentation/UI/guardian_registration.dart';

import 'package:women_safty/futures/auth/presentation/UI/registration.dart';
import 'package:women_safty/futures/auth/presentation/UI/user_login.dart';
import 'package:women_safty/futures/auth/presentation/UI/select_user_type_scree.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_bloc.dart';
import 'package:women_safty/futures/contact/presentation/ui/contact_screen.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_bloc.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/ui/guardian_rating.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/ui/guardian_screen.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/ui/gurdina_profile.dart';
import 'package:women_safty/futures/homepage/presentation/state/homePageBloc/homepage_bloc.dart';
import 'package:women_safty/futures/homepage/presentation/ui/gardian_list.dart';
import 'package:women_safty/futures/homepage/presentation/ui/home_page.dart';
import 'package:women_safty/futures/homepage/presentation/ui/messages.dart';
import 'package:women_safty/futures/message/presentation/state/messages_bloc.dart';
import 'package:women_safty/futures/message/presentation/ui/message_Screen.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_bloc.dart';
import 'package:women_safty/futures/profile/presentation/ui/profile_page.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_bloc.dart';
import 'package:women_safty/futures/rating/presentation/ui/rating_screen.dart';
import 'injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setUpLocator();

  runApp((DevicePreview(
      enabled: true,
      
      builder: (context) => const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.getIt<AuthBloc>(),
        ),
        BlocProvider<HomepageBloc>(
          create: (context) => di.getIt<HomepageBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => di.getIt<ProfileBloc>(),
        ),
        BlocProvider<RatingBloc>(
          create: (context) => di.getIt<RatingBloc>(),
        ),
        BlocProvider<ContactBloc>(
          create: (context) => di.getIt<ContactBloc>(),
        ),
        BlocProvider<GuardianBloc>(
          create: (context) => di.getIt<GuardianBloc>(),
        ),
         BlocProvider<MessagesBloc>(
          create: (context) => di.getIt<MessagesBloc>(),
        ),
         BlocProvider<AdminBloc>(
          create: (context) => di.getIt<AdminBloc>(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
        routes: {
          '/login': (context) => const LoginPage(),
          '/registration' : (context) => const SignUpPage(),
          '/home-page' : (context) => const HomePage(),
          '/profile-page' : (context) => const ProfilePage(),
          '/rating-screen' : (context) => const RatingScreen(),
          
          '/contact-screen' : (context) => const ContactScreen(),
          '/gardian-login' : (context) => const GuardianLogin(),
          '/gardian-home' : (context) => const GuardianScreen(),
          '/guardina-profile' : (context) => const GurdinaProfile(),
          '/gurdian-rating' : (context) => const GuardianRating(),
          '/messages' : (context) => const MessageScreen(),
          '/home-messages' : (context) => const MessagesText(),
          '/gardian-text' : (context) => const GardianList(),
          '/admin-login' : (context) => const AdminLogin(),
          '/admin-page' : (context) => const AdminPage(),
          '/user-list' : (context) => const AdminList(),
          '/gardian-data' :(context) => const GardianListData(),
          '/GuardianRegistration' : (context) => const GuardianRegistration()
         
        },
          home: const SelectUserTypeScree()),
    );
  }
}
