import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/tv_search_bloc.dart';
import '../widgets/tv_card_list.dart';

class TVSearchPage extends StatelessWidget {
  static const routeName = '/search-tv';

  const TVSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search TV Series')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<TVSearchBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text('Search Result', style: kHeading6),
            BlocBuilder<TVSearchBloc, TVSearchState>(
              builder: (context, state) {
                if (state is TVSearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      itemBuilder: (context, index) {
                        final tv = result[index];
                        return TVCard(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is TVSearchError) {
                  return Expanded(child: Center(child: Text(state.message)));
                } else if (state is TVSearchEmpty) {
                  return Expanded(child: Center(child: Text(state.message)));
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
