import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/top_rated_tv_bloc.dart';
import '../widgets/tv_card_list.dart';

class TopRatedTVPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';

  const TopRatedTVPage({super.key});

  @override
  State<TopRatedTVPage> createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        if (mounted) {
          context.read<TopRatedTVBloc>().add(FetchTopRatedTV());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Rated TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVBloc, TopRatedTVState>(
          builder: (context, state) {
            if (state is TopRatedTVLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopRatedTVHasData) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is TopRatedTVError) {
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
