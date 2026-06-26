import 'package:equatable/equatable.dart';

import '../../domain/entities/watchlist.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? type;

  const WatchlistTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.type,
  });

  factory WatchlistTable.fromEntity(Watchlist watchlist) => WatchlistTable(
        id: watchlist.id,
        title: watchlist.title,
        posterPath: watchlist.posterPath,
        overview: watchlist.overview,
        type: watchlist.type,
      );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        type: map['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type,
      };

  Watchlist toEntity() => Watchlist(
        id: id,
        title: title,
        posterPath: posterPath,
        overview: overview,
        type: type,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview, type];
}
