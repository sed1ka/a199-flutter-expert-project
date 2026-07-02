import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/popular_tv_bloc.dart';
import '../widgets/tv_card_list.dart';

class PopularTVPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTVPage({super.key});

  @override
  State<PopularTVPage> createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        if (mounted) {
          context.read<PopularTVBloc>().add(FetchPopularTV());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVBloc, PopularTVState>(
          builder: (context, state) {
            if (state is PopularTVLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularTVHasData) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTVError) {
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
