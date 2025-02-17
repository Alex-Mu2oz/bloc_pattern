// quote_state.dart
abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final String quote;
  final String author;
  QuoteLoaded({required this.quote, required this.author});
}

class QuoteError extends QuoteState {
  final String message;
  QuoteError(this.message);
}
