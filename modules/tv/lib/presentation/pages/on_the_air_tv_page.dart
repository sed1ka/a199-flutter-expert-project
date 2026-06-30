import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/on_the_air_tv_bloc.dart';
import '../widgets/tv_card_list.dart';

class OnTheAirTvPage extends StatefulWidget {
  static const routeName = '/on-the-air-tv';

  const OnTheAirTvPage({super.key});

  @override
  State<OnTheAirTvPage> createState() => _OnTheAirTvPageState();
}

class _OnTheAirTvPageState extends State<OnTheAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<OnTheAirTvBloc>().add(FetchOnTheAirTv()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('On The Air TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
          builder: (context, state) {
            if (state is OnTheAirTvLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OnTheAirTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is OnTheAirTvError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
