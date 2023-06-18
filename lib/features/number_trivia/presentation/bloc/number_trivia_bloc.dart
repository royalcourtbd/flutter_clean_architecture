// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture/core/util/input_converter.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
part 'number_trivia_event.dart';
part 'number_trivia_state.dart';


const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - The number must be a positive integer or zero.';


class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {


  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;



  NumberTriviaBloc(
    this.getConcreteNumberTrivia,
    this.getRandomNumberTrivia,
    this.inputConverter,
  ) : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) {

    });
  }

  NumberTriviaState get initialState => Empty();


  



  // Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {

  //   if(event is GetTriviaForConcreteNumber) {
  //     final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);
  //     yield* inputEither.fold(
  //       (failure) async* {
  //         yield const Error(message: INVALID_INPUT_FAILURE_MESSAGE);
  //       }, 
  //       (integer) async* {
  //         yield Loading();
  //         final failureOrTrivia = await getConcreteNumberTrivia(Params(number: integer));
  //         yield failureOrTrivia.fold(
  //           (failure) => Error(message: _mapFailureToMessage(failure)), 
  //           (trivia) => Loaded(trivia: trivia),
  //         );
  //       },
  //     );
  //   } else if(event is GetTriviaForRandomNumber) {
  //     yield Loading();
  //     final failureOrTrivia = await getRandomNumberTrivia(NoParams());
  //     yield failureOrTrivia.fold(
  //       (failure) => Error(message: _mapFailureToMessage(failure)), 
  //       (trivia) => Loaded(trivia: trivia),
  //     );
  //   }
  // }
}
