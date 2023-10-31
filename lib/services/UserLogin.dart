import 'package:logger/logger.dart';
import 'package:sign_in_register_app/models/user.dart';
import 'package:sign_in_register_app/services/database_helper.dart';
import 'package:sign_in_register_user_mgt_app/models/user.dart';
import 'package:sign_in_register_user_mgt_app/services/database_helper.dart';

class UserLogin{
  final DatabaseHelper dbHelper=DatabaseHelper();

  Future<User?> login(String email, String password) async{
    Logger logger=Logger();
    try {
      
      //encrypt the password
      password=dbHelper.encryptedPassword(password);
      User? authenticatedUser=await dbHelper.authenticateUser(email, password);
      if(authenticatedUser!=null){
        return authenticatedUser;
    }
    logger.e( 'Invalid credentials. Wrong email or password');
    return null;
    } catch (e) {
      logger.e( 'Login failed. Please try again later : $e');
      return null;
    }
  }
}