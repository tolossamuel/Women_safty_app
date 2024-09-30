

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/admin/domain/entity/admin_entity.dart';

abstract class AdminDatasource {
  Future<Either<Failure,AdminEntity>> getGardianData();
   Future<Either<Failure,AdminEntity>> getUserData();
}

class AdminDatasourceImpl implements AdminDatasource {
  @override
  Future<Either<Failure, AdminEntity>> getGardianData() async{
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      List<Map<String, dynamic>> guardiansList = snapshot.docs.map((doc) {
      return {
        'id': doc.id, // Get the document ID
        ...doc.data() as Map<String, dynamic>, // Get the document data
      };
    }).toList();
    AdminEntity adminEntities = AdminEntity(adminEntity: guardiansList);

    return Right(adminEntities); // Return the successful data
    }catch (e) {
    return Left(ServerFailure(message: 'Error fetching guardian data'));
  } 
  }

  @override
  Future<Either<Failure, AdminEntity>> getUserData() async{
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      List<Map<String, dynamic>> guardiansList = snapshot.docs.map((doc) {
      return {
        'id': doc.id, // Get the document ID
        ...doc.data() as Map<String, dynamic>, // Get the document data
      };
    }).toList();
    AdminEntity adminEntities = AdminEntity(adminEntity: guardiansList);

    return Right(adminEntities); // Return the successful data
    }catch (e) {
    return Left(ServerFailure(message: 'Error fetching guardian data'));
  } 
  }
  
}