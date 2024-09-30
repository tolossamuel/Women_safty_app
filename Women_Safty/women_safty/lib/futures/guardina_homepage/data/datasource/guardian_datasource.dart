
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/core/utility/emails_text.dart';
import 'package:women_safty/futures/guardina_homepage/data/model/guardian_model.dart';
import 'package:women_safty/futures/guardina_homepage/domain/entity/guardian_entity.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_event.dart';

abstract class GuardianDatasource {
  Future<Either<Failure,GuardianEntity>> getChildren();
  Future<Either<Failure,GuardianEntity>>getGardian();
}

class GuardianDatasourceImpl implements GuardianDatasource {
  final FirebaseAuth firebaseAuth;
  GuardianDatasourceImpl({
    required this.firebaseAuth
  });
  @override
  Future<Either<Failure, GuardianEntity>> getChildren() async{
    try {
      final User? user = firebaseAuth.currentUser;

      if (user == null) {
        return Future.value(left(ServerFailure(message: "No authenticated user found")));
      }
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      List<dynamic> homepageData = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Check if the guardianEmail matches the user's email
        if (user.email == data['guardianEmail']) {
          return {
            'name': data['name'],
            'email': data['email'],
            // If you have ratings, you can add them here
            // 'ratings': data['ratings'], // Example if you have a ratings field
          };
        }
        return null; // Return null if the condition is not met
      }).where((item) => item != null).toList();
    final GuardianModel guardianModel = GuardianModel(children: homepageData);
    final GuardianEntity guardianEntity = guardianModel.toEntity();
    return Right(guardianEntity);
    } catch (e) {
      return Left(ServerFailure(message: 'tyr again'));
    }
  }
  
  @override
  Future<Either<Failure, GuardianEntity>> getGardian() async{
    try {
      
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(EmailsText.userIds).get();
      if (userDoc.exists) {
      // Access the data
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      List<dynamic> result = [userData];
      final GuardianEntity guardianEntity = GuardianEntity(children: result);
      return Right(guardianEntity);
      
    } else {
      return Left(ServerFailure(message: 'no user'));
    }
    } catch (e) {
      return Left(ServerFailure(message: 'tyr again'));
    }
  }
  
}