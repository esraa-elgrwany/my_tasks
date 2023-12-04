import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_project/screens/log/login_tab.dart';
import 'package:todo_project/shared/firebase/firebaseFunctions.dart';
import 'package:todo_project/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpTab extends StatefulWidget {
  static const String routeName="signup";

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  bool secure=false;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Container(
            height: 200.h,
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.appTitle,style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color:Colors.white,fontSize: 28.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r))),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text("Sign up",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: primaryColor)),
                      ),
                      SizedBox(height: 30.h,),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your user name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text("User name",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: primaryColor)),
                          prefixIcon: Icon(Icons.person_outlined,color: primaryColor,),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color:primaryColor,
                            ),
                              borderRadius: BorderRadius.circular(12.r)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color:primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your Email";
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[com]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return "please enter valid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text("Email",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: primaryColor)),
                          prefixIcon: Icon(Icons.email_rounded,color: primaryColor,),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: primaryColor,
                            ),
                              borderRadius: BorderRadius.circular(12.r)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color:primaryColor,
                            ),
                              borderRadius: BorderRadius.circular(12.r)
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextFormField(
                       obscureText: secure?true:false,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your password";
                          }
                          RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                          if (!regex.hasMatch(value)) {
                            return 'Enter valid password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: Text("Password",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: primaryColor,
                                  )),
                          prefixIcon: Icon(Icons.lock,color: primaryColor,),
                          suffixIcon:IconButton(onPressed:() {
                           secure=!secure;
                           setState(() {
                           });
                          }, icon:Icon(Icons.remove_red_eye_rounded,color: primaryColor,),),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color:primaryColor,
                            ),
                              borderRadius: BorderRadius.circular(12.r)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color:primaryColor,
                            ),
                              borderRadius: BorderRadius.circular(12.r)
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FireBaseFunctions.createUser(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,LoginTab.routeName, (route) => false);
                                  },
                                  (message) {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Error"),
                                        content: Text(message),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Okey",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            style: ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(horizontal: 70, vertical: 8),
                                ),
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.circular(12.r),
                                ))),
                            child: Text("Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white))),),
                        SizedBox(height: 40.h),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, LoginTab.routeName);
                          },
                          child: Column(
                            children: [
                              Text("Already have an account ? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color:primaryColor,fontWeight: FontWeight.w200)),
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sign in",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: primaryColor)),
                                  SizedBox(width: 4.w,),
                                  Icon(Icons.arrow_circle_right_outlined,color: primaryColor,)
                                ],
                              ),

                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
