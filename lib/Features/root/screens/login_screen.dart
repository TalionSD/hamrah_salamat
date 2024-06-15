import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/validator/field_validator.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Features/profile/classes/user.dart';
import 'package:hamrah_salamat/Features/profile/data/avatars.dart';
import 'package:hamrah_salamat/Features/root/providers/root_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  late RootProvider _rootProvider;

  @override
  void initState() {
    _rootProvider = Provider.of<RootProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        color: Colors.transparent,
        child: Padding(
          padding: edgeInsetsGeometryOfScreens(context: context),
          child: Button(
            width: width,
            onPressed: () {
              if (_rootProvider.status != AppState.loading) {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  _rootProvider.createUser(
                    context: context,
                    user: User(
                      fullname: _fullnameController.text,
                      imageUrl: avatars.first,
                    ),
                  );
                }
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'بزن بریم',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: edgeInsetsGeometryOfScreens(context: context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Lottie.asset('assets/lottie/login.json'),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: TextFormField(
                      controller: _fullnameController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'این فیلد نمیتواند خالی باشد';
                        } else if (value!.length < 3) {
                          return 'کمتر از 3 حرف مجاز نمیباشد';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        CustomTextInputFormatter(),
                      ],
                      decoration: const InputDecoration(
                        label: Text('نام و نام خانوادگی'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 50,
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '🌱 به برنامه هوشمند و کاربردی',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: ' همراه سلامت ',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: 'خوش آمدید🌱',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
