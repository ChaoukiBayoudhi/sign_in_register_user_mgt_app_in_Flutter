import 'package:flutter/material.dart';
import 'package:sign_in_register_user_mgt_app/services/UserLogin.dart';

/*
I used StatefulWidget for the sign-in screen because it needs to be able to update its state
in response to user input. For example, the screen needs to update its state when the user types
in their email address and password, and when they click the sign-in button.

StatefulWidgets are able to update their state by calling the setState() method.
When this method is called, the Flutter framework will rebuild the widget.
This allows the widget to display its updated state.
*/
//he createState() method is required for all StatefulWidget classes.
//This method is called by the Flutter framework to create a new instance
//of the state class associated with the widget.

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();

}

//the createState() method returns an instance of the _SignInScreenState class.
//This class is a subclass of the State class.
//The State class is responsible for managing the state of the widget.
//It provides a number of methods that can be used to update the state of the widget,
//such as setState(),
/*
other methods that can also be used:

-->didChangeDependencies(): This method is called whenever the widget's dependencies change.
For example, if the widget is rebuilt because a parent widget has been rebuilt,
then didChangeDependencies() will be called. This method can be used to update the state
of the widget based on its new dependencies.
-->build(): This method is called whenever the widget needs to be rebuilt.
This can happen for a variety of reasons, such as if the state of the widget has changed,
or if the widget's dependencies have changed. The build() method is responsible for returning
a widget tree that represents the current state of the widget.
-->deactivate(): This method is called when the widget is removed from the widget tree.
This method can be used to clean up any resources that the widget is using.
*/

//the code could look like this:
//@override
 /* void didChangeDependencies() {
    Update the state of the widget based on its new dependencies.
  }

  @override
  void deactivate() {
     Clean up any resources that the widget is using.
  }

  @override
  Widget build(BuildContext context) {
     Return a widget tree that represents the current state of the widget.
  }
*/

class _SignInScreenState extends State<SignInScreen>{
/*
In the case of the sign-in screen, I used the setState() method to update the following state variables:

_emailError
_passwordError
When the user types in their email address and password, the validation methods for these fields will update
the corresponding state variable. If the validation fails, the error message will be displayed.

When the user clicks the sign-in button, the _login() method will be called. This method will first validate
the user's input. If the validation fails, the error messages will be displayed.
Otherwise, the method will try to log the user in. If the login is successful, the user will be navigated
to the next screen.

The _login() method is asynchronous, so it will return a Future object.
The Future object will be used to determine whether the login was successful or not.
If the login was successful, the user will be navigated to the next screen.
Otherwise, the error message will be displayed.
*/
  //the _emailError and _passwordError variables are used to store the error messages for the email address and password fields.
  String? _emailError;
  String? _passwordError;

  //the _emailController and _passwordController variables are used to control the email address and password fields.
  final  _emailController = TextEditingController();
  final  _passwordController = TextEditingController();

  //the _formKey variable is used to identify the form.
  final _formKey = GlobalKey<FormState>();

  //the _login() method is used to log the user in.
  Future<void> _login() async {
    //the _formKey.currentState!.validate() method is used to validate the form.
    //If the form is valid, the method will return true. Otherwise, it will return false.
    if (_formKey.currentState!.validate()) {
      //the _emailController.text and _passwordController.text variables are used to get the values of the email address and password fields.
      final String email = _emailController.text;
      final String password = _passwordController.text;
      //the userLogin variable is used to log the user in.
      final userLogin=UserLogin();
    //try to log the user in
    final authenticatedUser=await userLogin.login(email, password);
    if(authenticatedUser!=null){
      //navigate to the next screen
      Navigator.pushReplacementNamed(context, '/users');
    }else{
      //display an error message using setState()
      setState(() {
        _emailError='Invalid credentials. Wrong email or password.';
      });
    }
  }
}

//validate email using the lambda expression
void _validateEmail(String? value){
   if (value==null || value.isEmpty) {
    //if the email address field is empty, display an error message.
    _emailError = 'Email address is required. Please enter your email address.';
  } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
    //if the email address field does not contain @, . and at least 2 characters after the last dot,
    //then display an error message.
    _emailError = 'Please enter a valid email address.';
  }
  Else(){
    //if the email address is valid, then set the _emailError variable to null.
    _emailError = null;
  }
  //the setState() method is used to update the state of the widget.
  //When this method is called, the Flutter framework will rebuild the widget.
  //This allows the widget to display its updated state.
  setState(() {
    _emailError = _emailError;
  });
}
void _cancel(){
  Navigator.pop(context);
}

//validate the password using (just not empty)
void _validatePassword(String? value){
  if (value==null || value.isEmpty) {
    //if the password field is empty, display an error message.
    _passwordError = 'Password is required. Please enter your password.';
  } else {
    //if the password is valid, then set the _passwordError variable to null.
    _passwordError = null;
  }
  //the setState() method is used to update the state of the widget.
      //When this method is called, the Flutter framework will rebuild the widget.
      //This allows the widget to display its updated state.
  setState(() {
    _passwordError = _passwordError;
  });

}


//override build function
@override
Widget build(BuildContext context){
  //Scaffold is a widget that provides a framework for implementing the basic material design visual layout structure.
  //It provides APIs for showing drawers, snack bars, and bottom sheets.
  //It also provides APIs for handling taps, gestures, and other user interactions.
  //The Scaffold widget is used to implement the basic material design visual layout structure.

return Scaffold(
  //An AppBar is a widget in Flutter that is used to display a toolbar at the top of the screen.
  //It typically contains a title, a leading button (such as a back button), and a list of trailing
  //actions (such as a menu button).
  //AppBars are useful for providing a consistent navigation experience across your app.
  //They also provide a way to display important information to the user, such as the title
  //of the screen and the current state of the app.
  //AppBar can contains a title, a leading back button, a trailing menu button, and a list of actions.
  //AppBars can also be used to display more complex information, such as a search bar or a tab bar.
  //The AppBar widget is used to implement the app bar.
  //The AppBar widget is a subclass of the StatelessWidget class.
  //This means that it cannot be updated once it has been created.
  //If you want to update the app bar, you will need to create a new instance of the AppBar widget.
  //The AppBar widget is typically used as the top-level widget in a Scaffold widget.
  //Example :
  /*****
   * AppBar(
  title: Text('My App'),
  leading: IconButton(
  *  icon: Icon(Icons.arrow_back),
  *  onPressed: () => Navigator.pop(context),
  *),
  actions: [
  *  IconButton(
  *    icon: Icon(Icons.search),
  *    onPressed: () {},
  *  ),
  *],
  bottom: TabBar(
  *  tabs: [
  *    Tab(text: 'Tab 1'),
  *    Tab(text: 'Tab 2'),
  *  ],
  *),
*), ******/
//This AppBar contains a title, a leading back button, a trailing search button, and a tab bar.
//The title is displayed in the center of the app bar.
//The leading back button is displayed on the left side of the app bar.
//The trailing search button is displayed on the right side of the app bar.
//The tab bar is displayed at the bottom of the app bar.
//The tab bar contains two tabs: Tab 1 and Tab 2.
//The TabBar widget is used to implement the tab bar.
//The TabBar widget is a subclass of the StatelessWidget class.

  appBar: AppBar(
    //we use const with the constructor to improve performance
    title: const Text('Sign In'),
  ), //AppBar
  //The body property is used to specify the widget that will be displayed
  //in the body of the scaffold.
  //In this case, the body is a Form widget.
  //The Form widget is used to implement a form.
  //The Form widget is a subclass of the StatefulWidget class.
  //This means that it can be updated once it has been created.
  //The Form widget is typically used as the top-level widget in a Scaffold widget.
  //The Form widget contains a list of FormField widgets.
  //Each FormField widget is used to implement a form field.
  //The FormField widget is a subclass of the StatelessWidget class.
  //This means that it cannot be updated once it has been created.
  //If you want to update the form field, you will need to create a new instance of the FormField widget.
  //The FormField widget is typically used as a child of the Form widget.
  //The FormField widget contains a TextFormField widget.
  //The TextFormField widget is used to implement a text field.
  //It's used to get the user input
  //The TextFormField widget is a subclass of the StatelessWidget class.
  body: Form(
    //the key property is used to identify the form.
    //This is useful if you want to validate the form.
    //The key property is a GlobalKey object.
    key: _formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter your email address',
            errorText: _emailError,
          ), //InputDecoration
          //the validator property is used to validate the form field.
          //The validator property is a function that takes a String as an argument and returns a String.
          //If the validator returns null, then the form field is valid.
          //If the validator returns a String, then the form field is invalid.
          //The validator property is called whenever the user types in the form field.
          //The validator property is called whenever the user clicks the sign-in button.
          validator: (value) {
            //the _validateEmail() method is used to validate the email address.
            _validateEmail(value);
            //the validator property must return null if the form field is valid.
            //If the form field is invalid, then the validator property must return a String.
            //If the form field is invalid, then the validator property must return an error message.
            return _emailError;
          },
          ),  //TextFormField
          //SizedBox is a widget in Flutter that can be used to specify the size of a child widget.
          //It is useful for creating widgets that have a specific size, regardless of the size of their parent widget.
          //SizedBox can be used to create widgets with a fixed width and height, or to create widgets that
          //fill the available space. It can also be used to create widgets that are centered within their parent widget.
          //example :
          /**
           * SizedBox(
           *   width: double.infinity,
           *  height: double.infinity,
           *  child: Center(
           *     child: Text('This widget is centered within its parent widget.'),
           *   ),
           * )
           **/
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              errorText: _passwordError,
            ), //InputDecoration
            validator: (value) {
              _validatePassword(value);
              return _passwordError;
            },
            //the obscureText property is used to hide the text that the user types in the form field.
            //If the obscureText property is set to true, then the text that the user types in the form field will be hidden.
            //If the obscureText property is set to false, then the text that the user types in the form field will be visible.
            obscureText: true,
          ) , //TextFormField
          const SizedBox(height: 20),
          //ElevatorButton is a widget in Flutter that can be used to create a button.
          //It is useful for creating buttons that have a specific size, regardless of the size of their parent widget.
          //ElevatorButton can be used to create buttons with a fixed width and height, or to create buttons that have a specific size.
          //there is also TextButton which is used to create a linked label
          //
          ElevatedButton(
            onPressed: _login,
            child: const Text('Sign In'),
          ),  //ElevatedButton
          ElevatedButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
          ),
        //add a link for registration if the user hasn't an account
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            textStyle: const TextStyle(
              fontSize: 20,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              ),
          ), //TextButton.styleFrom
          child: const Text('Don\'t have an account? Register here.'),
        ),  //TextButton
      ],
    )
    ),
);
}
            
}
