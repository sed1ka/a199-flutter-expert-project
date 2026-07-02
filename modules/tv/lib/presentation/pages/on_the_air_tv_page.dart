import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/on_the_air_tv_bloc.dart';
import '../widgets/tv_card_list.dart';

class OnTheAirTVPage extends StatefulWidget {
  static const routeName = '/on-the-air-tv';

  const OnTheAirTVPage({super.key});

  @override
  State<OnTheAirTVPage> createState() => _OnTheAirTVPageState();
}

class _OnTheAirTVPageState extends State<OnTheAirTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<OnTheAirTVBloc>().add(FetchOnTheAirTV());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('On The Air TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTVBloc, OnTheAirTVState>(
          builder: (context, state) {
            if (state is OnTheAirTVLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OnTheAirTVHasData) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is OnTheAirTVError) {
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
