import 'package:path/path.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../util/log.util.dart';
import 'database_table.dart';

class DatabaseManager {
  static late Database database;

  static Future<void> delete(
    dynamic id, {
    required String table,
  }) async {
    LogUtil.devLog(
      "DatabaseManager",
      message: "Deleting from table: $table at id: $id",
    );
    await database.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteAll(String table) async {
    LogUtil.devLog(
      "DatabaseManager",
      message: "Deleting all rows from table: $table",
    );
    await database.delete(table);
  }

  static Future<void> update(
    dynamic id, {
    required Map<String, dynamic> data,
    required String table,
  }) async {
    LogUtil.devLog(
      "DatabaseManager",
      message: "Updating table: $table at id: $id",
    );
    await database.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> readAll(String table) async {
    LogUtil.devLog(
      "DatabaseManager",
      message: "Reading all from table: $table",
    );
    return await database.query(table);
  }

  static Future<Map<String, dynamic>?> read(
    List<dynamic> whereArgs, {
    required String table,
    required String whereClause,
  }) async {
    LogUtil.devLog(
      "DatabaseManager",
      message: "Reading from table: $table where $whereClause",
    );
    try {
      return (await database.query(
        table,
        where: whereClause,
        whereArgs: whereArgs,
      ))
          .first;
    } catch (e) {
      return null;
    }
  }

  static Future<void> insert(
    Map<String, dynamic> data, {
    required String table,
  }) async {
    LogUtil.devLog(
      "DatabaseManager",
      message: "Inserting into table: $table\nData: $data",
    );
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await database.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> init() async {
    LogUtil.devLog(
      "DatabaseManager",
      message: "Initializing database manager",
    );

    // Init ffi loader if needed.
    sqfliteFfiInit();

    List<DatabaseTable> tables = <DatabaseTable>[
      //TODO: Add database tables if any. They must extend [DatabaseTable]
    ];

    database = await databaseFactoryFfi.openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(inMemoryDatabasePath, 'database.db'),
      options: OpenDatabaseOptions(
          // When the database is first created, create a register table.
          // onCreate: (db, version) {
          //   LogUtil.devLog(
          //     "DatabaseManager",
          //     message: "Creating tables",
          //   );
          //   // Run the CREATE TABLE statement on the database.
          //   return db.execute(tables.map((e) => e.createScript).join("\n"));
          // },
          // Set the version. This executes the onCreate function and provides a
          // path to perform database upgrades and downgrades.
          ),
    );
  }

  static void dispose() {
    LogUtil.devLog(
      "DatabaseManager",
      message: "Disposing database manager",
    );
    database.close();
  }
}
