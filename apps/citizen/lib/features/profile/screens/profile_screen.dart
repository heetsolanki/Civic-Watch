import 'package:citizen/exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String phone = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final data = await AppPreferences.getUser();
    setState(() {
      name = data['name'] ?? '';
      phone = data['phone'] ?? '';
      email = data['email'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
          child: Column(
            spacing: 16,
            children: [
              TopCard(name: name, email: email, phone: phone),
              SizedBox(height: 50,),
              Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 10,),
                  Text('Profile tab is under maintenance'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
