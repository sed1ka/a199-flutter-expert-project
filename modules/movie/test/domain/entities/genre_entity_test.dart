import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/genre.dart';

void main() {
  group('Genre Entity', () {
    final tGenreId = 28;
    final tGenreName = 'Action';

    test('Genre entity should have correct properties', () {
      final genre = Genre(id: tGenreId, name: tGenreName);

      expect(genre.id, tGenreId);
      expect(genre.name, tGenreName);
    });

    test('Two Genre entities with same properties should be equal', () {
      final genre1 = Genre(id: tGenreId, name: tGenreName);
      final genre2 = Genre(id: tGenreId, name: tGenreName);

      expect(genre1, equals(genre2));
    });

    test('Genre entities with different id should not be equal', () {
      final genre1 = Genre(id: tGenreId, name: tGenreName);
      final genre2 = Genre(id: 12, name: tGenreName);

      expect(genre1, isNot(genre2));
    });

    test('Genre entities with different name should not be equal', () {
      final genre1 = Genre(id: tGenreId, name: tGenreName);
      final genre2 = Genre(id: tGenreId, name: 'Comedy');

      expect(genre1, isNot(genre2));
    });

    test('Genre props should include id and name', () {
      final genre = Genre(id: tGenreId, name: tGenreName);

      expect(genre.props, [tGenreId, tGenreName]);
    });

    test('Multiple genres with same properties should be equal', () {
      final genres1 = [
        Genre(id: 28, name: 'Action'),
        Genre(id: 12, name: 'Adventure'),
      ];

      final genres2 = [
        Genre(id: 28, name: 'Action'),
        Genre(id: 12, name: 'Adventure'),
      ];

      expect(genres1, equals(genres2));
    });
  });
}
