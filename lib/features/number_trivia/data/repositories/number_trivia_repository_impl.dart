// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/exception.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/network/network_info.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
