import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_season/provider/provider_widget.dart';
import 'package:flutter_season/view_model/login_model.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'login_field_widget.dart';
import 'login_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// outside new  inside dispose may be crash. watch it
  /// 理论上应该在当前页面dispose,
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                LoginTopPanel(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      LoginLogo(),
                      LoginFormContainer(
                          child: ProviderWidget<LoginModel>(
                        model: LoginModel(Provider.of(context)),
                        onModelReady: (model) {
                          _nameController.text = model.getLoginName();
                        },
                        builder: (context, model, child) {
                          return Form(
                            onWillPop: () async {
                              return !model.busy;
                            },
                            child: child,
                          );
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              LoginTextField(
                                label: "用户名",
                                icon: Icons.person_outline,
                                controller: _nameController,
                                textInputAction: TextInputAction.next,
                              ),
                              LoginTextField(
                                controller: _passwordController,
                                label: "密码",
                                icon: Icons.lock_outline,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                              ),
                              LoginButton(_nameController, _passwordController),
                              SingUpWidget(_nameController),
                            ]),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.busy
          ? ButtonProgressIndicator()
          : Text(
              "登录",
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 6),
            ),
      onPressed: model.busy
          ? null
          : () {
              var formState = Form.of(context);
              if (formState.validate()) {
                model
                    .login(nameController.text, passwordController.text)
                    .then((value) {
                  if (value) {
//                    showToast("登录成功");
                  } else {
                    showToast(model.errorMessage);
                  }
                });
              }
            },
    );
  }
}

class SingUpWidget extends StatefulWidget {
  final nameController;

  SingUpWidget(this.nameController);

  @override
  _SingUpWidgetState createState() => _SingUpWidgetState();
}

class _SingUpWidgetState extends State<SingUpWidget> {
  TapGestureRecognizer _recognizerRegister;

  @override
  void initState() {
    _recognizerRegister = TapGestureRecognizer()
      ..onTap = () async {
        // 将注册成功的用户名,回填如登录框
        showToast("快去注册吧~~~");
      };
    super.initState();
  }

  @override
  void dispose() {
    _recognizerRegister.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(text: "暂无账号?", children: [
        TextSpan(
            text: "注册",
            recognizer: _recognizerRegister,
            style: TextStyle(color: Theme.of(context).accentColor))
      ])),
    );
  }
}

class ButtonProgressIndicator extends StatelessWidget {

  final double size;
  final Color color;

  ButtonProgressIndicator(
      { this.size: 24, this.color: Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(color),
        ));
  }
}