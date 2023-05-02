import 'dart:io';
import 'package:login_sqlite/service/usermodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBMHelper{
 
static final DBMHelper instanse = DBMHelper();
static Database? _db;

Future<Database> get db async =>_db ??= await initDatabase();

initDatabase()async{
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentDirectory.path, 'notes.db');
  var db = await openDatabase(path, version: 1, onCreate: _oncreate);
  return db;
}

init()async{
  Directory directory = await getApplicationDocumentsDirectory();
  String path  = join(directory.path,'note.db');
  var dbm = await openDatabase(path,version: 1, onCreate: dbmcreatea);
  return dbm;
}
dbmcreatea(Database fb, int version)async{
  await fb.execute('''
  CREATE TABLE fbnote(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
  )
''');
}

Future<int> intrecord(UserModel user)async{
Database fbm = await instanse.db;
return await fbm.insert('note', user.toMap());
}

_oncreate(Database db, int version)async{
await db.execute('''
CREATE TABLE notes(
  id INTEGER PRIMARY KEY,
  email TEXT NOT NULL,
  address TEXT NOT NULL)''');
}

Future<int> InsertRecord(UserModel userModel)async{  
Database db = await instanse.db; 
return await db.insert('notes', userModel.toMap());
}

Future<List<UserModel>> getRecord()async{
Database db =  await instanse.db;
var user = await db.query('notes',orderBy: 'email');
List<UserModel> userlist = user.isNotEmpty?
user.map((e) => UserModel.fromMap(e)).toList()
:[];
return userlist;
}


Future<int> deleteRecord(int id)async{
  Database db = await instanse.db;
  return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
}


Future<int> updateRecord(UserModel userModel)async{
  Database db = await instanse.db;
  return await db.update('notes',userModel.toMap(),
  where: "id = ?", whereArgs: [userModel.id]
   );
}
}