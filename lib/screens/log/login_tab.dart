import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/layout/home_layout.dart';
import 'package:todo_project/screens/log/signUp_tab.dart';
import 'package:todo_project/shared/firebase/firebaseFunctions.dart';
import 'package:todo_project/shared/providers/Myprovider.dart';
import 'package:todo_project/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginTab extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
 bool secure=false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: Column(
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( AppLocalizations.of(context)!.appTitle,style: Theme.of(context)
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
                          child: Text("Sign in",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: primaryColor)),
                        ),
                        SizedBox(
                          height: 60.h,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color:primaryColor)),

                            prefixIcon: Icon(Icons.email_rounded,color: primaryColor,),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(12.r)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(12.r)),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: secure?true:false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter your password";
                            }
                            RegExp regex =
                                RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                            if (!regex.hasMatch(value)) {
                              return 'Enter valid password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text("Password",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color:
                                         primaryColor,
                                    )),
                            prefixIcon: Icon(Icons.lock,color: primaryColor,),
                            suffixIcon:IconButton(onPressed:() {
                              secure=!secure;
                              setState(() {
                              });
                            }, icon:Icon(Icons.remove_red_eye_rounded,color: primaryColor,),),

                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.w,
                                  color: primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(12.r)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.w,
                                  color: primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(12.r)),
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                         Center(
                           child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    FireBaseFunctions.login(
                                      emailController.text,
                                      passwordController.text,
                                      () {
                                        pro.initUser();
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          HomeLayout.routeName,
                                          (route) => false,
                                        );
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
                                                  child: Text("okay",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white))),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          horizontal: 70, vertical: 8),
                                    ),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(12.r),
                                    ))),
                                child: Text("Sign in",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white))),
                         ),

                        SizedBox(height: 60.h),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, SignUpTab.routeName);
                            },
                              child: Column(
                                children: [
                                  Text("Don't have an account ? ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color:primaryColor,fontWeight: FontWeight.w200)),
                                  SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sign Up",
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
            ),),
          ],
        ),
    );
  }
}
