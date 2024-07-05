// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PictureDao? _pictureDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `picture` (`copyright` TEXT NOT NULL, `date` TEXT NOT NULL, `explanation` TEXT NOT NULL, `hdurl` TEXT NOT NULL, `mediaType` TEXT NOT NULL, `serviceVersion` TEXT NOT NULL, `title` TEXT NOT NULL, `url` TEXT NOT NULL, PRIMARY KEY (`url`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PictureDao get pictureDAO {
    return _pictureDAOInstance ??= _$PictureDao(database, changeListener);
  }
}

class _$PictureDao extends PictureDao {
  _$PictureDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pictureModelInsertionAdapter = InsertionAdapter(
            database,
            'picture',
            (PictureModel item) => <String, Object?>{
                  'copyright': item.copyright,
                  'date': item.date,
                  'explanation': item.explanation,
                  'hdurl': item.hdurl,
                  'mediaType': item.mediaType,
                  'serviceVersion': item.serviceVersion,
                  'title': item.title,
                  'url': item.url
                }),
        _pictureModelDeletionAdapter = DeletionAdapter(
            database,
            'picture',
            ['url'],
            (PictureModel item) => <String, Object?>{
                  'copyright': item.copyright,
                  'date': item.date,
                  'explanation': item.explanation,
                  'hdurl': item.hdurl,
                  'mediaType': item.mediaType,
                  'serviceVersion': item.serviceVersion,
                  'title': item.title,
                  'url': item.url
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PictureModel> _pictureModelInsertionAdapter;

  final DeletionAdapter<PictureModel> _pictureModelDeletionAdapter;

  @override
  Future<List<PictureModel>> getPictures() async {
    return _queryAdapter.queryList('SELECT * FROM picture',
        mapper: (Map<String, Object?> row) => PictureModel(
            copyright: row['copyright'] as String,
            date: row['date'] as String,
            explanation: row['explanation'] as String,
            hdurl: row['hdurl'] as String,
            mediaType: row['mediaType'] as String,
            serviceVersion: row['serviceVersion'] as String,
            title: row['title'] as String,
            url: row['url'] as String));
  }

  @override
  Future<List<PictureModel>> getPicturesByName(String title) async {
    return _queryAdapter.queryList('SELECT * FROM picture where title LIKE ?1',
        mapper: (Map<String, Object?> row) => PictureModel(
            copyright: row['copyright'] as String,
            date: row['date'] as String,
            explanation: row['explanation'] as String,
            hdurl: row['hdurl'] as String,
            mediaType: row['mediaType'] as String,
            serviceVersion: row['serviceVersion'] as String,
            title: row['title'] as String,
            url: row['url'] as String),
        arguments: [title]);
  }

  @override
  Future<List<PictureModel>> getPicturesByDate(String date) async {
    return _queryAdapter.queryList('SELECT * FROM picture where date = ?1',
        mapper: (Map<String, Object?> row) => PictureModel(
            copyright: row['copyright'] as String,
            date: row['date'] as String,
            explanation: row['explanation'] as String,
            hdurl: row['hdurl'] as String,
            mediaType: row['mediaType'] as String,
            serviceVersion: row['serviceVersion'] as String,
            title: row['title'] as String,
            url: row['url'] as String),
        arguments: [date]);
  }

  @override
  Future<void> insertPicture(PictureModel picture) async {
    await _pictureModelInsertionAdapter.insert(
        picture, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePicture(PictureModel picture) async {
    await _pictureModelDeletionAdapter.delete(picture);
  }
}
