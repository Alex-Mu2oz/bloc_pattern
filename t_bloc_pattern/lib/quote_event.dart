// quote_event.dart
abstract class QuoteEvent {}

class FetchQuote extends QuoteEvent {}

class ResetQuote extends QuoteEvent {}