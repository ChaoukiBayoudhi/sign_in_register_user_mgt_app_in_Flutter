//implement functions that execute SQL requests on the PostgreSQL database
//like insert user, update user, select * from users, etc.
import 'package:crypt/crypt.dart';

import 'package:logger/logger.dart';
import 'package:postgres/postgres.dart';
import 'package:sign_in_register_user_mgt_app/models/user.dart';

class DatabaseHelper{
  Logger logger=Logger();
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
    try{
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
    }catch(e){
      logger.e('Error !! $e');
      return [];
    }
  }

  //get user by id
  Future<Map<String,dynamic>> getUserById(int id) async{
    try{
    await connection.open();
    var result=await connection.query('select * from users where id=$id');
    //convert from PostgreSQLResult to Map<String,dynamic>
    var user=result.map((row){
      Map<String,dynamic> user={};
      row.toColumnMap().forEach((key, value) {
        user[key]=value;
      });
      return user;
    }).toList().first;
    
    await connection.close();
    return user;
    }catch(e){
      logger.e('Error !! $e');
      return {};
    }
  }
//encrypted the password using sha512 algorithm
  String encryptedPassword(String password){
    //var bytes=utf8.encode(password);
    var digest=Crypt.sha512(password);
    return digest.toString();
  }
  //insert user
  Future<bool> insertUser(Map<String,dynamic> user) async{
    try {
      await connection.open();
      //encrypt the password
      if(user.containsKey("password")){
        user["password"]=encryptedPassword(user["password"]);
      }
      await connection.execute(
        //the triple ' are used because the string is split on more than one line
        //the @name, @familyName, ... are parameters of the SQL request
        //substitutionValuees:user => is used to replace each parameter on the SQL request by
        //the user attribute that has the same name
        //like @name is replace by user['name']
        //substitutionValues is a Map with parameters name as Keys.
        '''
        insert into users(name,family_name,email,birth_day,password,phone,role,photo)
        values(@name,@familyName,@email,@birth_day,@password,@phone,@role,@photo)
        ''',substitutionValues: user);
      await connection.close();
      return true;
    } catch (e) {
      logger.e('Error !! $e');
      return false;
    }
  }
  //update user
  Future<bool> updateUser(Map<String,dynamic> user) async{
    try {
      await connection.open();
      //encrypt the password
      if(user.containsKey("password")){
        user["password"]=encryptedPassword(user["password"]);
      }
      await connection.execute(
        '''
        update users set name=@name,family_name=@familyName,email=@email,
        birth_day=@birth_day,password=@password,phone=@phone,role=@role,photo=@photo
        where id=@id
        ''',substitutionValues: user);
      await connection.close();
      return true;
    } catch (e) {
      logger.e('Error !! $e');
      return false;
    }
  }
    //delete the user
    Future<bool> deleteUse(int id) async{

    try {
      await connection.open();
      await connection.execute('delete from users where id=$id');
      connection.close();
      return true;
    } catch (e) {
      logger.e('Error !! $e');
      return false;
    }
  }

  //authenticate user using email and crypt password
  Future<User?> authenticateUser(String email, String password) async {
    try {
      var result = await connection.query('SELECT * FROM users WHERE email=@email;',
          substitutionValues: {'email': email});
      // Convert from Future<List<QueryRow>> to List<Map<String, dynamic>>
      var users = result.map((row) {
        Map<String, dynamic> users = {};
        row.toColumnMap().forEach((key, value) {
          users[key] = value;
        });
        return users;
      }).toList();
      if (users.isNotEmpty) {
        var user = users.first;
        //encrypt the password
        password = encryptedPassword(password);
        if (user['password'] == password) {
          return User.fromJson(user);
        }
      }
      return null;
    } catch (e) {
      // Handle any errors, e.g., logging an error message or return an empty list.
      logger.e("Error in authenticateUser: $e");
      return null;
    }
  }


}