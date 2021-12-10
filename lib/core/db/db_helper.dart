import 'package:flutter_note_app/core/models/note_model.dart';
import 'package:flutter_note_app/core/models/tasks_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;
  static Database _dbT;
  static final int _version = 1;
  static final String _tablenameNote = 'notes';
  static final String _tablenameTask = 'tasks';

  static Future<void> initDbNote() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'notes.db';
      _db = await openDatabase(_path, version: _version, onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tablenameNote(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, date STRING)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> initDbTask() async {
    if (_dbT != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _dbT = await openDatabase(_path, version: _version, onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tablenameTask(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, date STRING)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertNote(Note note) async {
    return await _db.insert(_tablenameNote, note.toJson());
  }

  static Future<int> deleteNote(Note note) async {
    return await _db.delete(_tablenameNote, where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<List<Map<String, dynamic>>> queryNote() async {
    print("query function called");
    return _db.query(_tablenameNote);
  }

  static Future<int> updateNote(Note note) async {
    print("update function called");
    return await _db.rawUpdate(
      "UPDATE $_tablenameNote SET title = ?, note = ? WHERE id = ? ",
      [note.title, note.note, note.id],
    );
  }

  static Future<int> insertTask(Task task) async {
    return await _dbT.insert(_tablenameTask, task.toJson());
  }

  static Future<int> deleteTask(Task task) async {
    return await _dbT.delete(_tablenameTask, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, dynamic>>> queryTask() async {
    print("query task function called");
    return _dbT.query(_tablenameTask);
  }

  static Future<int> updateTask(Task task) async {
    print("update task function called");
    return await _dbT.rawUpdate(
      "UPDATE $_tablenameTask SET task = ? WHERE id = ? ",
      [task.task, task.id],
    );
  }
}
