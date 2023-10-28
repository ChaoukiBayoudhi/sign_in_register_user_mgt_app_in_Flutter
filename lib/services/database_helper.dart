//implement functions that execute SQL requests on the PostgreSQL database
//like insert user, update user, select * from users, etc.
import 'package:postgres/postgres.dart';

class databaseHelper{
  //create a Connection to the PostgreSQL database
  final connection=PostgreSQLConnection('localhost',
  5432, 'users_db',username: 'user_bi1',password:'user_bi1');

  //get all users from the Users table
  //sync, await and Future are all used to make the function asynchronous
  //Future is used to return a value from an asynchronous function
  //Map<String, dynamic> is used to store a user
  //List<Map<String, dynamic>> is used to store a list of users
  //the query() function is used to execute a SELECT SQL request
  //the execute() function is used to execute an INSERT, UPDATE, DELETE, Create, alter, etc. 
  Future<List<Map<String, dynamic>>> getAllUsers() async{
    await connection.open();
    var result=await connection.query('select * from users');
    //convert from PostgreSQLResult format to List<Map<String, dynamic>>
    var users= result.map((row) {
      Map<String, dynamic> users = {};
      row.toColumnMap().forEach((key, value) {
        users[key] = value;
      });
      return users;
    }).toList();
    await connection.close();
    return users;
  }
  
}