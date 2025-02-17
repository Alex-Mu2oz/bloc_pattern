// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quote_bloc.dart';
import 'quote_event.dart';
import 'quote_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => QuoteBloc(),
        child: QuoteScreen(),
      ),
    );
  }
}

class QuoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reseñas")),
      body: Center(
        child: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if (state is QuoteInitial) {
              return Text("Obtener una nueva reseña");
            } else if (state is QuoteLoading) {
              return CircularProgressIndicator();
            } else if (state is QuoteLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.quote, textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text("- ${state.author}", style: TextStyle(fontStyle: FontStyle.italic)),
                ],
              );
            } else if (state is QuoteError) {
              return Text(state.message, style: TextStyle(color: Colors.red));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<QuoteBloc>().add(FetchQuote()),
            child: Icon(Icons.refresh),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => context.read<QuoteBloc>().add(ResetQuote()),
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
