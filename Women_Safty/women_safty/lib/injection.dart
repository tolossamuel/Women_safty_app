
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:get_it/get_it.dart';
import 'package:women_safty/firebase_options.dart';
import 'package:women_safty/futures/admin/data/datasource/admin_datasource.dart';
import 'package:women_safty/futures/admin/data/repository/admin_repo_impl.dart';
import 'package:women_safty/futures/admin/domain/repository/admin_repository.dart';
import 'package:women_safty/futures/admin/domain/usecase/admin_usecase.dart';
import 'package:women_safty/futures/admin/presentation/state/admin_bloc.dart';
import 'package:women_safty/futures/auth/data/data_source/auth_data_source.dart';
import 'package:women_safty/futures/auth/data/repository/auth_repo_impl.dart';
import 'package:women_safty/futures/auth/domain/repository/auth_repository.dart';
import 'package:women_safty/futures/auth/domain/usecase/atuh_usecase.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:women_safty/futures/contact/data/datasource/contact_datasource.dart';
import 'package:women_safty/futures/contact/data/repository/contact_repo_impl.dart';
import 'package:women_safty/futures/contact/domain/repository/contact_repository.dart';
import 'package:women_safty/futures/contact/domain/usecase/contact_usecase.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_bloc.dart';
import 'package:women_safty/futures/guardina_homepage/data/datasource/guardian_datasource.dart';
import 'package:women_safty/futures/guardina_homepage/data/repository/guardian_repo_impl.dart';
import 'package:women_safty/futures/guardina_homepage/domain/repository/guardian_repository.dart';
import 'package:women_safty/futures/guardina_homepage/domain/usecase/guardian_usecase.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_bloc.dart';
import 'package:women_safty/futures/homepage/data/datasource/homepage_datasource.dart';
import 'package:women_safty/futures/homepage/data/repository/homepage_repo_impl.dart';
import 'package:women_safty/futures/homepage/domain/repository/homepage_repository.dart';
import 'package:women_safty/futures/homepage/domain/usecase/homepage_usecase.dart';
import 'package:women_safty/futures/homepage/presentation/state/homePageBloc/homepage_bloc.dart';
import 'package:women_safty/futures/message/data/datasource/messages_datasource.dart';
import 'package:women_safty/futures/message/data/repository/messages_repo_impl.dart';
import 'package:women_safty/futures/message/domain/repository/messages_repository.dart';
import 'package:women_safty/futures/message/domain/usecase/messages_usecase.dart';
import 'package:women_safty/futures/message/presentation/state/messages_bloc.dart';
import 'package:women_safty/futures/profile/data/datasource/profile_datasource.dart';
import 'package:women_safty/futures/profile/data/repository/profile_repo_impl.dart';
import 'package:women_safty/futures/profile/domain/repository/profile_repository.dart';
import 'package:women_safty/futures/profile/domain/usecase/profile_usecase.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_bloc.dart';
import 'package:women_safty/futures/rating/data/datasource/rating_datasource.dart';
import 'package:women_safty/futures/rating/data/repository/rating_repo_impl.dart';
import 'package:women_safty/futures/rating/domain/repository/rating_repository.dart';
import 'package:women_safty/futures/rating/domain/usecase/rating_usecase.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_bloc.dart';

final getIt = GetIt.instance;
Future<void> setUpLocator() async {
  try{
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  // Register FirebaseAuth and other services
  
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(firebaseAuth: getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(authDataSource: getIt()));
  getIt.registerLazySingleton(() => AuthUsecase(authRepository: getIt()));
  getIt.registerFactory(() => AuthBloc(authUsecase: getIt()));


  getIt.registerLazySingleton<HomepageDatasource>(() => HomepageDatasourceImpl(firebaseAuth: getIt()));
  getIt.registerLazySingleton<HomepageRepository>(() => HomepageRepoImpl(datasource: getIt()));
  getIt.registerLazySingleton(() => HomepageUsecase(repository: getIt()));
  getIt.registerFactory(() => HomepageBloc(homepageUsecase: getIt()));

   getIt.registerLazySingleton<ProfileDatasource>(() => ProfileDatasourceImpl(firebaseAuth: getIt()));
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepoImpl(profileDatasource: getIt()));
  getIt.registerLazySingleton(() => ProfileUsecase(profileRepository: getIt()));
  getIt.registerFactory(() => ProfileBloc(profileUsecase: getIt()));

  getIt.registerLazySingleton<RatingDatasource>(() => RatingDatasourceImpl(firebaseAuth: getIt()));
  getIt.registerLazySingleton<RatingRepository>(() => RatingRepoImpl(ratingDatasource: getIt()));
  getIt.registerLazySingleton(() => RatingUsecase(ratingRepository: getIt()));
  getIt.registerFactory(() => RatingBloc(ratingUsecase: getIt()));

  getIt.registerLazySingleton<ContactDatasource>(() => ContactDatasourceImpl(firebaseAuth: getIt()));
  getIt.registerLazySingleton<ContactRepository>(() => ContactRepoImpl(contactDatasource: getIt()));
  getIt.registerLazySingleton(() => ContactUsecase(contactRepository: getIt()));
  getIt.registerFactory(() => ContactBloc(contactUsecase: getIt()));

  getIt.registerLazySingleton<GuardianDatasource>(() => GuardianDatasourceImpl(firebaseAuth: getIt()));
  getIt.registerLazySingleton<GuardianRepository>(() => GuardianRepoImpl(guardianDatasource: getIt()));
  getIt.registerLazySingleton(() => GuardianUsecase(guardianRepository: getIt()));
  getIt.registerFactory(() => GuardianBloc(guardianUsecase: getIt()));

  getIt.registerLazySingleton<MessagesDatasource>(() => MessagesDatasourceImpl());
  getIt.registerLazySingleton<MessagesRepository>(() => MessagesRepoImpl(messagesDatasource: getIt()));
  getIt.registerLazySingleton(() => MessagesUsecase(messagesRepository: getIt()));
  getIt.registerFactory(() => MessagesBloc(messagesUsecase: getIt()));

  getIt.registerLazySingleton<AdminDatasource>(() => AdminDatasourceImpl());
  getIt.registerLazySingleton<AdminRepository>(() => AdminRepoImpl(adminDatasource: getIt()));
  getIt.registerLazySingleton(() => AdminUsecase(adminRepository: getIt()));
  getIt.registerFactory(() => AdminBloc(adminUsecase: getIt()));
  } catch (e){
    print(e.toString());
  }

}