// quote_bloc.dart
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'quote_event.dart';
import 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitial());

  @override
  Stream<QuoteState> mapEventToState(QuoteEvent event) async* {
    if (event is FetchQuote) {
      yield QuoteLoading();
      try {
        final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          yield QuoteLoaded(quote: data[0]['q'], author: data[0]['a']);
        } else {
          yield QuoteError("Error al obtener la reseña");
        }
      } catch (e) {
        yield QuoteError("Error de conexión");
      }
    } else if (event is ResetQuote) {
      yield QuoteInitial();
    }
  }
}
