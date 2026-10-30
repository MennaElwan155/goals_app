
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals_app/cubits/goals_cubit/goals_state.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit() : super (InitialState());

  static GoalsCubit get(context) => BlocProvider.of<GoalsCubit>(context);

  var addTextController = TextEditingController();

  initSql()async{
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'goals.db');

    Database database = await openDatabase(path, version: 1, onCreate: (Database db, int version)async{
      await db.execute('CREATE TABLE Goals (id INTEGER PRIMARY KEY, name TEXT)',
      );
    }
    );
  }
  List<Map> goalsList = [];
  getData ()async{
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'goals.db');
    Database database = await openDatabase(path);

    await database.rawQuery('SELECT * FROM Goals').then((value){
      goalsList = value;
      emit(GetSuccessState());
    }).catchError((error){
      emit(GetFailureState());
      print(error.toString());
    }
    );
    database.close();
  }
  insertData(String name)async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'goals.db');
    Database database = await openDatabase(path);

    await database.rawInsert('INSERT INTO Goals(name) VALUES(?)', [name])
        .then((value){
      emit(InsertSuccessState());
    })
        .catchError((error){
      emit(InsertFailureState());
      print(error.toString());
    }
    );
    database.close();
  }
  removeDate(id)async{
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'goals.db');
    Database database = await openDatabase(path);

    await database.rawDelete('DELETE FROM Goals WHERE id = ?',[id])
        .then((value){
      emit(DeleteSuccessState());
    })
        .catchError((error){
      emit(DeleteFailureState());
      print(error.toString());
    }
    );
    database.close();
  }
}